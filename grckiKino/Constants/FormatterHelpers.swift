//
//  FormatterHelpers.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import Foundation
class StaticHelpers {
        
    static let dateTimeFormatterHHmm: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "CET")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    static let dateTimeFormatterMMss: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "mm:ss"
        return dateFormatter
    }()
    
    static let dateTimeFormatterHHmmss: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()
    
}


