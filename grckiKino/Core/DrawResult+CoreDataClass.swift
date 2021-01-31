//
//  DrawResult+CoreDataClass.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//
//

import Foundation
import CoreData
import UIKit

@objc(DrawResult)
public class DrawResult: NSManagedObject {
    
    func updateForList(with json: NSDictionary){
        self.drawId = json[CodingKeys.drawId.rawValue] as! Int64
        self.drawTime = json[CodingKeys.drawTime.rawValue] as! Int64
        self.gameId = json[CodingKeys.gameId.rawValue] as! Int64
    }
}

extension DrawResult{
    enum CodingKeys: String, CodingKey {
        case drawId
        case drawTime
        case gameId
        case list
    }
    
    func getDrawNumbers() -> [Int] {
        var list = [Int]()
        if let newArray = self.list as? NSArray {
            newArray.forEach { (int) in
                list.append(int as! Int)
            }
        }
        return list
    }
    
    func getTimeValue() -> Date {
        let startTimeConverted = Double(self.drawTime)
        let date = Date(timeIntervalSince1970: (startTimeConverted / 1000.0))
        return date
    }
}


