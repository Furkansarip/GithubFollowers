//
//  FollowerCell.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 25.09.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
   static let reuseID = "FollowerCell"
    var avatarImageView = GFAvatarImage(frame: .zero)
    var usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 12)
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower : Follower){
        usernameLabel.text = follower.login
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        let padding : CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo:avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
}
