//
//  String+Ext.swift
//  GithubFollowersApp
//
//  Created by Furkan Sarı on 1.10.2022.
//

import Foundation

extension String {
    func convertToDate() ->Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone   = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayDate()->String{
        guard let date = self.convertToDate() else {return "N/A"}
        return date.convertToMonthYearFormat()
        
    }
}
