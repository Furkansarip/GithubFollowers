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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        autocorrectionType = .no
        backgroundColor = .tertiarySystemBackground
        font = UIFont.preferredFont(forTextStyle: .title2)
        placeholder = "Enter a username"
        
    }
    
}
