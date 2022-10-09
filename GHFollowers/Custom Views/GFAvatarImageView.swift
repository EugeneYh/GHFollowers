//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 09.10.2022.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
