//
//  EmptyStateView.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 28.10.2022.
//

import UIKit

final class GFEmptyStateView: UIView {
    private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String){
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubviews(messageLabel, imageView)
        
        messageLabel.textColor = .secondaryLabel
        messageLabel.numberOfLines = 3
        
        imageView.image = Images.emptyStateLogo?.withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE2nd3rdGen || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant).isActive = true
        
        let imageCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE2nd3rdGen || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: imageCenterYConstant).isActive = true
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.2),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 150),
        ])
    }
}
