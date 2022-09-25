//
//  FollowerListVC.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 24.09.2022.
//

import UIKit

class FollowerListVC: UIViewController {
    var username : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
       
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

  

}
