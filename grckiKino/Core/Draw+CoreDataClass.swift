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
        self.drawSelected = false
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
        case drawSelected
    }
    
    func getTimeValue() -> Date {
        let startTimeConverted = Double(self.drawTime)
        let date = Date(timeIntervalSince1970: (startTimeConverted / 1000.0))
        return date
    }
    
    func changeSelectedStatus(){
        if self.drawSelected == false {
            self.drawSelected = true
        } else {
            self.drawSelected = false
        }
    }
    
    func getTimer() -> Date {
        let timeNow = Date()
        let timeLeft = self.getTimeValue().timeIntervalSince1970 - timeNow.timeIntervalSince1970
        let newTime = Date(timeIntervalSince1970: (timeLeft))
        return newTime
    }
    
    func getTimerStringValue() -> String {
        var stringToReturn = String()
        let timeNow = Date()
        let timeLeft = self.getTimeValue().timeIntervalSince1970 - timeNow.timeIntervalSince1970
        let newTime = Date(timeIntervalSince1970: (timeLeft))
        if timeLeft > 3599 {
            stringToReturn = StaticHelpers.dateTimeFormatterHHmmss.string(from: newTime)
        } else if timeLeft <= 0 {
            stringToReturn = "Vreme je isteklo"
        } else {
            stringToReturn = StaticHelpers.dateTimeFormatterMMss.string(from: newTime)
        }
        return stringToReturn
    }
    
}
