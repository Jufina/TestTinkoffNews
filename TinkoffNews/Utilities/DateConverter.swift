//
//  DateConverter.swift
//  TinkoffNews
//
//  Created by jufina on 23.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation

class DateConverter {
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormate
        
        return dateFormatter
    }()
    
    static func timestampToDateString(time: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: time/Constants.milisecondsPerSecond)
        
        return dateFormatter.string(from: date)
    }
}
