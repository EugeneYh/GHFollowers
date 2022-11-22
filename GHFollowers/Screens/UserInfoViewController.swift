//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 29.10.2022.
//

import UIKit

protocol UserInfoViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGithubFollowers(for user: User)
}

class UserInfoViewController: UIViewController {
    
    private let headerVC = GFUserInfoHeaderViewController()
    private let repoItemVC = GFRepoItemViewController()
    private let followersVC = GFFollowersItemViewController()
    
    private let headerView  = UIView()
    private let firstView = GFItemInfoView()
    private let secondView = GFItemInfoView()
    
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    
    //MARK: - Layout paddings/sizes
    private let itemHeight: CGFloat = 140
    private let viewPadding: CGFloat = 20
    
    private var views: [UIView] = []
    private var user: User?
    
    var username: String?
    
    
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
                        self.configureVCs(with: user)
                        self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
                    }
                case .failure(let error):
                    self.presentAlertVCInMainThread(title: "Someting went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureVCs(with user: User) {
        repoItemVC.user = user
        repoItemVC.delegate = self
        
        followersVC.user = user
        followersVC.delegate = self
        
        add(childVC: repoItemVC, to: firstView)
        add(childVC: followersVC, to: secondView)
    }
    
    private func setupUI() {

        views = [headerView, firstView, secondView, dateLabel]
        views.forEach { itemView in
            self.view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewPadding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewPadding),
            ])
        }
        

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            firstView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: viewPadding),
            firstView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: viewPadding),
            secondView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: viewPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
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

extension UserInfoViewController: UserInfoViewControllerDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertVCInMainThread(title: "Page not found", message: "The user's page was not found due to unexpected error.", buttonTitle: "Got it")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGithubFollowers(for user: User) {
        // open followerrs list vc with the related followers
        print("show followers")
    }
    
    
}
