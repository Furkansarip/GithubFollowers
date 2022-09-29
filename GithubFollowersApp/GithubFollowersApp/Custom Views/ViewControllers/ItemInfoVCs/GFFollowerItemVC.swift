//
//  GFFollowerItemVC.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 29.09.2022.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()

       configureFollowerItems()
    }
    

    func configureFollowerItems(){
        itemOneInfoView.set(itemInfoType: .followers, withCount: user.followers)
        itemTwoInfoView.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemRed, title: "Get Followers")
    }

}
