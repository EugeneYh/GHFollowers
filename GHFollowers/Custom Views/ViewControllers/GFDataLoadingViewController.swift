//
//  GFDataLoadingViewController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 03.12.2022.
//

import UIKit

class GFDataLoadingViewController: UIViewController {
    
    private var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showActivityIndicator() {
        containerView = UIView(frame: view.bounds)
        view.addSubviews(containerView)
        
        containerView.alpha = 0
        containerView.backgroundColor = .systemBackground
        
        UIView.animate(withDuration: 0.3) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            #warning("Handle the network reachability")
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
