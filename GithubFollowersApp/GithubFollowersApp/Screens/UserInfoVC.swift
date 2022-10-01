//
//  UserInfoVC.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 27.09.2022.
//

import UIKit
import SafariServices
protocol UserInfoVCDelegate : class {
    func didTapFollowers(for user : User)
    func didTapProfile(for user : User)
}

class UserInfoVC: UIViewController {
    var username : String!
    var headerView              = UIView()
    var itemOne                 = UIView()
    var itemTwo                 = UIView()
    let dateLabel               = GFBodyLabel(textAlignment: .center)
    weak var delegate                : FollowersListVCDelegate!
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
                    self.configureElementUI(with: user)
                }
                
            case.failure(let error):
                self.GFAlertPresent(title: "Something wrong!", message: error.rawValue, buttonTitle: "OK")            }
        }
    }
    
    func configureElementUI(with user : User){
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemOne)
        self.add(childVC: followerItemVC, to: self.itemTwo)
        self.dateLabel.text = user.createdAt.convertToDisplayDate()
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

extension UserInfoVC : UserInfoVCDelegate {
    func didTapFollowers(for user: User) {
        guard user.followers != 0 else {
            GFAlertPresent(title: "No Followers", message: "So Sad", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    func didTapProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else
        {
            GFAlertPresent(title: "Invalid URL", message: "bad url", buttonTitle: "ok")
            return
        }
        safariVC(with: url)
        
    }
    
    
}
