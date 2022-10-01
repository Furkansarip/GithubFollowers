//
//  GFRepoItemVC.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 29.09.2022.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    func configureItems(){
        itemOneInfoView.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemTwoInfoView.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapProfile(for: user)
    }
    

    

}
