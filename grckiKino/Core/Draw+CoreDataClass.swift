//
//  Draw+CoreDataClass.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//
//

import Foundation
import CoreData

@objc(Draw)
public class Draw: NSManagedObject {

    func updateForList(with json: NSDictionary){
        self.drawBreak = json[CodingKeys.drawBreak.rawValue] as! Int64
        self.drawId = json[CodingKeys.drawId.rawValue] as! Int64
        self.drawTime = json[CodingKeys.drawTime.rawValue] as! Int64
        self.gameId = json[CodingKeys.gameId.rawValue] as! Int64
        self.status = json[CodingKeys.status.rawValue] as! String
        self.visualDraw = json[CodingKeys.visualDraw.rawValue] as! Int64
    }
}

extension Draw {
    enum CodingKeys: String, CodingKey {
        case drawBreak
        case drawId
        case drawTime
        case gameId
        case status
        case visualDraw
    }
    
    func getTimeValue() -> Date {
        let startTimeConverted = Double(self.drawTime)
        let date = Date(timeIntervalSince1970: (startTimeConverted / 1000.0))
        return date
    }
}
