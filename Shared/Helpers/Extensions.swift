//
//  Extensions.swift
//  iOS
//
//  Created by James Meli on 6/30/20.
//

import Foundation


extension Date {
    
    func timeAgoDisplay() -> String {
        
        let secondsAgo = Int(self.timeIntervalSince(Date()))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        let year = 12 * month
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days"
        } else if secondsAgo < month {
            return "\(secondsAgo / week) weeks"
        } else if secondsAgo < year {
            return "\(secondsAgo / week) weeks"
        }
        
        return ""
    }
    

}
