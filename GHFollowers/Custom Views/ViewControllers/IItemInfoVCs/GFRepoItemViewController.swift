//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 18.11.2022.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFRepoItemViewControllerDelegate? 
    
    override var user: User? {
        didSet {
            if let user = user {
                itemView1.setupItemView(for: .repo, with: user.publicRepos)
                itemView2.setupItemView(for: .gists, with: user.publicGists)
            } else {
                return
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    override func actionButtonTapped() {
        guard let user = user else { return }
        delegate?.didTapGithubProfile(for: user)
    }

    private func configureItems() {
        actionButton.set(backgroundColor: .systemPurple, title: "Github  Profile")
    }
}
