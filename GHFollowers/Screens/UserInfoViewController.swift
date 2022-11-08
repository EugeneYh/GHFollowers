//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 29.10.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String?
    private let headerVC = GFUserInfoHeaderViewController()
    private let headerView  = UIView()
    private let firstView = UIView()
    private let secondView = UIView()
    
    //MARK: - Layout paddings/sizes
    private let itemHeight: CGFloat = 140
    private let viewPadding: CGFloat = 20
    
    private var views: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
        setupViewController()
        getUserInfo()
    }
    
    private func getUserInfo() {
        guard let username = username else { return }
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    self.headerVC.user = user
                    DispatchQueue.main.async {
                        self.add(childVC: self.headerVC, to: self.headerView)
                    }
                case .failure(let error):
                    self.presentAlertVCInMainThread(title: "Someting went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func setupUI() {

        views = [headerView, firstView, secondView]
        views.forEach { itemView in
            self.view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewPadding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewPadding),
            ])
        }
        
        firstView.backgroundColor = .systemPink
        secondView.backgroundColor = .blue
                
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            firstView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: viewPadding),
            firstView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: viewPadding),
            secondView.heightAnchor.constraint(equalToConstant: itemHeight),
            
        ])
    }
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        
        let doneNavButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closeVC))
        navigationItem.rightBarButtonItem = doneNavButton
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func closeVC() {
        self.dismiss(animated: true)
    }
}
