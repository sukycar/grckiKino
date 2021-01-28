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

extension String{
    func trimDate() -> String{
        let rr = try! NSRegularExpression(pattern: ".+?(?=\\.).{0,4}")
        if let ss = rr.firstMatch(in: self, options: [], range: NSMakeRange(0, self.utf16.count)) {
            let range = ss.range
            let start = self.index(self.startIndex, offsetBy: range.lowerBound)
            let end = self.index(self.startIndex, offsetBy: range.upperBound)
            let subString = self[start..<end]
            return String(subString)
        }else{
            if !self.contains(".") {
                return self + ".000"
            }
        }
        return ""
        
    }
    func trimDateToSeconds() -> String{
        let elements = self.components(separatedBy: ".")
        if elements.count > 1 {
            return elements[0]
        }else{
            return self
        }
    }
}

