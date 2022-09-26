//
//  GFAvatarImage.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 25.09.2022.
//

import UIKit

class GFAvatarImage: UIImageView {

    
    let placeholder = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        image = placeholder
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
