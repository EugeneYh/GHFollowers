//
//  UITableView+Extension.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 12.12.2022.
//

import UIKit

extension UITableView {
    func removeExcessRows() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
