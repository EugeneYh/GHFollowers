//
//  GFFollowersItemViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 18.11.2022.
//

import UIKit

class GFFollowersItemViewController: GFItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }

    private func configureItems() {
        guard let user = self.user else { return }
        itemView1.setupItemView(for: .following, with: user.following ?? 0)
        itemView2.setupItemView(for: .followers, with: user.followers ?? 0)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
