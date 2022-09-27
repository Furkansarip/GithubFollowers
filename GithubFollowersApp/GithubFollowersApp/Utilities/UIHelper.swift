//
//  UIHelper.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 26.09.2022.
//

import UIKit

struct UIHelper {
   static func createThreeColumnFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.scrollDirection      = .vertical
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth)
        
        return flowLayout
    }
}
