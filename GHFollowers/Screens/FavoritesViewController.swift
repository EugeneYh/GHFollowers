//
//  FavoritesViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 14.08.2022.
//

import UIKit

class FavoritesViewController: GFDataLoadingViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var favorites = [Follower]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavorites()
    }
    
    private func getFavorites() {
        PersistanceManager.retreiveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedFavorites):
                if fetchedFavorites.isEmpty {
                    self.showEmptyStateView(with: "No favorites?\nAdd one on the followers screen", in: self.view)
                } else {
                    self.favorites = fetchedFavorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentAlertVCInMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Try again")
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubviews(tableView)
        
        tableView.removeExcessRows()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
        tableView.rowHeight = 80
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        let favorite = favorites[indexPath.row]
        cell.set(with: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC =  FollowerListViewController(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                return
            }
            self.presentAlertVCInMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
