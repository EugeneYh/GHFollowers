//
//  GFSecondaryLabel.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 03.11.2022.
//

import UIKit

class GFSecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.0
        lineBreakMode = .byTruncatingTail 
        translatesAutoresizingMaskIntoConstraints = false
    }
}
