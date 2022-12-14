//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 21.08.2022.
//

import UIKit

class FollowerListViewController: GFDataLoadingViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearched = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    @objc func addToFavorites() {
        showActivityIndicator()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.hideActivityIndicator()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.updateWith(favorite: favorite, actionType: .save) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentAlertVCInMainThread(title: "Success", message: "User was successfully added", buttonTitle: "Cool")
                        return
                    }
                    self.presentAlertVCInMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentAlertVCInMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        let addNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem = addNavButton
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelpers.createThreeItemsFlowLayout(for: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find a user"
        self.navigationItem.searchController = searchController
    }
    
    private func getFollowers(username: String, page: Int) {
        showActivityIndicator()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isSearched = false
            
            self.hideActivityIndicator()

            switch result {
                case .success(let followers):
                    if followers.count < 100 {
                        self.hasMoreFollowers = false
                    }
                    self.followers.append(contentsOf: followers)
                
                    // MARK: Check if user have any followers
                    if self.followers.isEmpty {
                        let message = "This user doesn't have any followers yet ????. You can be first!"
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                
                    self.updateData(for: self.followers)
                case .failure(let error):
                    self.presentAlertVCInMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower> (collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.setCell(follower: follower)
            return cell
        })
    }
    
    private func updateData(for data: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

//MARK: Pagination 

extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeigh = scrollView.contentSize.height
        let screenHeight = view.frame.size.height
        
        if offsetY > contentHeigh - screenHeight {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearched ? filteredFollowers : followers
        let user = activeArray[indexPath.row]
        let destVC = UserInfoViewController()
        destVC.delegate = self
        destVC.username = user.login
        let userInfoNavVC = UINavigationController(rootViewController: destVC)
        present(userInfoNavVC, animated: true)
    }
}

extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let input = searchController.searchBar.text, !input.isEmpty else {
            filteredFollowers.removeAll()
            updateData(for: followers)
            isSearched = false
            return
        }
        isSearched = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(input.lowercased()) }
        updateData(for: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        updateData(for: followers)
    }
}

extension FollowerListViewController: UserInfoViewControllerDelegate {
    func didUpdateFollowersList(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
