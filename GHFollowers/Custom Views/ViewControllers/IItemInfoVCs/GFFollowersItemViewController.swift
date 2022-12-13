//
//  GFFollowersItemViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 18.11.2022.
//

import UIKit

protocol GFFollowersItemViewControllerDelegate: AnyObject {
    
    func didTapGithubFollowers(for user: User)
}

class GFFollowersItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFFollowersItemViewControllerDelegate? 

    override var user: User? {
        didSet {
            if let user = user {
                itemView1.setupItemView(for: .following, with: user.following ?? 0)
                itemView2.setupItemView(for: .followers, with: user.followers ?? 0)
            } else {
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }

    private func configureItems() {
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        guard let user = user else { return }
        delegate?.didTapGithubFollowers(for: user)
    }
}
