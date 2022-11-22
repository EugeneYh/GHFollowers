//
//  GFItemInfoViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 16.11.2022.
//

import UIKit

class GFItemInfoViewController: UIViewController {
    
    private let stackView = UIStackView()
    var user: User?
    
    let itemView1 = GFItemInfoView()
    let itemView2 = GFItemInfoView()
    let actionButton = GFButton()
    
    private   let padding: CGFloat = 20
    
    weak var delegate: UserInfoViewControllerDelegate?
    
    //MARK: - Alternative method of initialising the user property
//    init(user: User) {
//        super.init(nibName: nil, bundle: nil)
//        self.user = user
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20

        setupUI()
        setupActionButton()
    }
    
    private func setupActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}
    
    private func setupStackView() {
        stackView.addArrangedSubview(itemView1)
        stackView.addArrangedSubview(itemView2)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        // stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        setupStackView()
        
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    

}
