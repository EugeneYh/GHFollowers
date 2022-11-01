//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 29.10.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavButton()
        getUserInfo()
        
    }
    
    private func getUserInfo() {
        guard let username = username else { return }
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    self.presentAlertVCInMainThread(title: "Someting went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func setupNavButton() {
        let doneNavButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closeVC))
        navigationItem.rightBarButtonItem = doneNavButton
    }
    
    @objc private func closeVC() {
        self.dismiss(animated: true)
    }
}
