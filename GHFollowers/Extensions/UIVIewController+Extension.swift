//
//  UIVIewController+Extension.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 30.09.2022.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentAlertVCInMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.dismissButtonStyle = .close
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
 
