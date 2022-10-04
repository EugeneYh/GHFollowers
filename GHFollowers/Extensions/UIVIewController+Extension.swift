//
//  UIVIewController+Extension.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 30.09.2022.
//

import UIKit

extension UIViewController {
    func presentAlertVCInMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
