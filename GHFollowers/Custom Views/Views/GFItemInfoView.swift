//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 13.11.2022.
//

import UIKit

enum ItemType {
    case repo, gists, following, followers
}

class GFItemInfoView: UIView {
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .secondaryLabel
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 12),
            countLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func setupItemView(for itemType: ItemType, with count: Int) {
        switch itemType {
        case .repo:
            iconImageView.image = UIImage(systemName: SFSymbols.repo)
            titleLabel.text = "Public Repos"
        case .gists:
            iconImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            iconImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            iconImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }


}
