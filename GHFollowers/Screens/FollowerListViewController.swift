//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 21.08.2022.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
                case .success(let followers):
                    print(followers)
                
                case .failure(let error):
                    self.presentAlertVCInMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
