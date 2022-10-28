//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 21.08.2022.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        getFollowers(username: username, page: page)
        configureCollectionView()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelpers.createThreeItemsFlowLayout(for: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func getFollowers(username: String, page: Int) {
        showActivityIndicator()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.hideActivityIndicator()

            switch result {
                case .success(let followers):
                    if followers.count < 100 {
                        self.hasMoreFollowers = false
                    }
                    self.followers.append(contentsOf: followers)
                
                    // MARK: Check if user have any followers
                    if self.followers.isEmpty {
                        let message = "This user doesn't have any followers yet 😊. You can be first!"
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                
                    self.updateData()
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
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
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
}
