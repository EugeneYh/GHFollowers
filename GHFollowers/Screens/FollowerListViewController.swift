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
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentAlertVCInMainThread(title: "Bad stuff happened", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Followers count - ", followers.count)
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
