//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 18.11.2022.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }

    private func configureItems() {
        guard let user = self.user else { return }
        itemView1.setupItemView(for: .repo, with: user.publicRepos)
        itemView2.setupItemView(for: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github  Profile")
    }
}
