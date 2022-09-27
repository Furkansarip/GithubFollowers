//
//  GFAvatarImage.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 25.09.2022.
//

import UIKit

class GFAvatarImage: UIImageView {

    let cache       = NetworkManager.shared.cache
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
    
    func downloadImage(from urlString : String){
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        guard let urlString = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: urlString) { [weak self] data, response, error in
            guard let self = self else {return}
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
            
            
        }
        task.resume()
        
    }

}
