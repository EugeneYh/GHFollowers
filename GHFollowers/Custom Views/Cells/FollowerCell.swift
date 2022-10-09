//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 09.10.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = String(describing: FollowerCell.self)
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    private let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(follower: Follower) {
        usernameLabel.text = follower.login
    }
    
    private func setupView() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
