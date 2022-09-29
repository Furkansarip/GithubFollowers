//
//  UserInfoVC.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 27.09.2022.
//

import UIKit

class UserInfoVC: UIViewController {
    var username : String!
    var headerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        layoutUI()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
                
            case.failure(let error):
                self.GFAlertPresent(title: "Something wrong!", message: error.rawValue, buttonTitle: "OK")            }
        }
      
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func layoutUI(){
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
            
        ])
    }
    
    func add(childVC:UIViewController, to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    

}