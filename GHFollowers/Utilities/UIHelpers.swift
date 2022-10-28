//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 13.10.2022.
//

import UIKit

enum UIHelpers {
    static func createThreeItemsFlowLayout(for view: UIView) -> UICollectionViewFlowLayout{
        let screenWidth = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avaliableScreenWidth = screenWidth - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = avaliableScreenWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
