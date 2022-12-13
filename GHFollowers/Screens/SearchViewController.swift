//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 14.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextFiled()
    let searchButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    private var isUsernameEntered: Bool {
        if let username = usernameTextField.text {
            return !username.isEmpty
        } else {
            return false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, searchButton)
        
        configureLogoImageView()
        configureusernameTextField()
        configureSearchButton()
        createDismissTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
    }
    
    @objc private func pushFollowersListVC() {
        guard isUsernameEntered else {
            presentAlertVCInMainThread(title: "Empty Username", message: "Please enter a username. We need to know who we look for 😊.", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followersListVC = FollowerListViewController(username: usernameTextField.text ?? "")
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    private func createDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    private func configureLogoImageView() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.logo
        
        let logoImageTopConstraing: CGFloat = DeviceTypes.isiPhoneSE2nd3rdGen || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logoImageTopConstraing).isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureusernameTextField() {
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
