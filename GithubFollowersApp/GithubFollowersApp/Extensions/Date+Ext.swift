//
//  Date+Ext.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 1.10.2022.
//

import Foundation


extension Date {
    
    func convertToMonthYearFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
        
    }
    
}
