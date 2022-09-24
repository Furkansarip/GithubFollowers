//
//  GFTextField.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 22.09.2022.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        autocorrectionType = .no
        backgroundColor = .tertiarySystemBackground
        placeholder = "Enter a username"
        
    }
    
}
