//
//  GFEmptyStateView.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 27.09.2022.
//

import UIKit

class GFEmptyStateView: UIView {

    
    var messageLabel    = GFTitleLabel(textAlignment: .center, fontSize: 28)
    var emptyImageView  = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(message:String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(emptyImageView)
        messageLabel.numberOfLines      = 3
        messageLabel.textColor          = .secondaryLabel
        emptyImageView.image = UIImage(named: "empty-state-logo")
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            emptyImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
           
        
        ])
    }

}
