//
//  GFButton.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 18.08.2022.
//

import UIKit

class GFButton: UIButton {
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom init
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal )
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
    }
}
