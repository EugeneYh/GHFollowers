//
//  GFUserInfoHeaderViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 07.11.2022.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {
    
    private let userAvatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private let fullNameLabel = GFSecondaryLabel(fontSize: 18)
    private let locationImageView = UIImageView()
    private let locationLabel = GFSecondaryLabel(fontSize: 18)
    private let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User? {
        didSet{
            if let user = user {
                self.userAvatarImageView.downloadAvatarImage(from: user.avatarUrl)
                DispatchQueue.main.async {
                    self.usernameLabel.text = user.login
                    self.fullNameLabel.text = user.name
                    self.locationLabel.text = user.location ?? "No location"
                    self.bioLabel.text = user.bio ?? "No bio"
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()

    }
    
    private func addSubviews() {
        view.addSubview(userAvatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(fullNameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    private func setupUI() {
        addSubviews()
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 18
        let textFromImagePadding: CGFloat = 12
        
        bioLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            userAvatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 90),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: userAvatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: textFromImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            fullNameLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: textFromImagePadding),
            fullNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: textFromImagePadding),
            locationImageView.bottomAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor),
            locationImageView.heightAnchor.constraint(equalToConstant: 22),
            locationImageView.widthAnchor.constraint(equalToConstant: 22),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: textFromImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
