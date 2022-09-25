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
        NetworkManager.shared.getFollowers(username: username, page: 1) { result in
            switch result {
            case .success(let follewers):
                print(follewers)
            case .failure(let error):
                self.GFAlertPresent(title: "Bad Stuff Happening", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

  

}
