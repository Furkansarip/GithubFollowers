//
//  UserInfoVC.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 27.09.2022.
//

import UIKit

class UserInfoVC: UIViewController {
    var username : String!
    var headerView              = UIView()
    var itemOne                 = UIView()
    var itemTwo                 = UIView()
    let dateLabel               = GFBodyLabel(textAlignment: .center)
    var itemViews : [UIView]    = []
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        getUserInfo()
        layoutUI()
       
        
      
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemOne)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemTwo)
                    self.dateLabel.text = user.createdAt.convertToDisplayDate()
                }
                
            case.failure(let error):
                self.GFAlertPresent(title: "Something wrong!", message: error.rawValue, buttonTitle: "OK")            }
        }
    }
    
    func layoutUI(){
        itemViews = [headerView,itemOne,itemTwo,dateLabel]
        let padding : CGFloat = 20
        let itemHeight : CGFloat = 140
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemTwo.topAnchor.constraint(equalTo: itemOne.bottomAnchor, constant: padding),
            itemTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func add(childVC:UIViewController, to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    

}
