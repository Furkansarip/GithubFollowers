//
//  UIViewController+Ext.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 24.09.2022.
//

import UIKit
import SafariServices
fileprivate var containerView : UIView!
extension UIViewController {
    func GFAlertPresent(title:String,message:String,buttonTitle:String){
        
        DispatchQueue.main.async {
            let alert = GFAlertVC(title: title, message: message, buttonTitle:buttonTitle)
               alert.modalPresentationStyle = .overFullScreen
               alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
        }
        
        
    }
    
    func safariVC(with url:URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func isLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
    func dissmissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func emptyStateView(with message:String,in view:UIView){
        let emptyState = GFEmptyStateView(message: message)
        emptyState.frame = view.bounds
        view.addSubview(emptyState)
    }
}
