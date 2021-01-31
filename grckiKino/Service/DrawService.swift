//
//  DrawService.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import Foundation
import UIKit
import CoreData


class DrawService {
    
    class func getAll(){
        let router = Router.getDataForGame(gameId: GameType.grckiKino.rawValue)
        let task = URLSession.shared.dataTask(with: router.fullUrl()) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            // serialize data into object
            DataManager.shared.work { (context) in
                if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    if let jsonArray = json as? NSArray {
                        for(index, json) in jsonArray.enumerated() {
                            if let json = json as? NSDictionary {
                                let id = json["drawId"] as! Int64
                                let fetchRequest = Draw.fetchRequest() as NSFetchRequest
                                let predicate = NSPredicate(format: "drawId = %d", id)
                                fetchRequest.predicate = predicate
                                let item: Draw? = context.update(predicate: NSPredicate(format: "drawId = %d", id))
                                item?.updateForList(with: json)
                            }
                        }
                        try! context.save()
                        try! context.parent?.save()
                    }
                } catch {
                    print("Decoding failed")
                }
                }
            }
        }
        task.resume()
    }
    
    class func getDrawsByDate(withDates fromDate: String, toDate: String){
        let router = Router.getDrawsForDate(gameId: GameType.grckiKino.rawValue, fromDate: fromDate, toDate: toDate)
        let task = URLSession.shared.dataTask(with: router.fullUrl()) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            // serialize data into object
            DataManager.shared.work { (context) in
                if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let jsonDict = json as? NSDictionary
                    if let jsonArray = jsonDict?["content"] as? NSArray {
                        for(index, json) in jsonArray.enumerated() {
                            if let json = json as? NSDictionary {
                                let id = json["drawId"] as! Int64
                                let winningNumbers = json["winningNumbers"] as? NSDictionary
                                let numbersList = winningNumbers?["list"] as? [Int]
                                let fetchRequest = DrawResult.fetchRequest() as NSFetchRequest
                                let predicate = NSPredicate(format: "drawId = %d", id)
                                fetchRequest.predicate = predicate
                                let item: DrawResult? = context.update(predicate: NSPredicate(format: "drawId = %d", id))
                                item?.updateForList(with: json)
                                item?.list = numbersList as NSObject?
                            }
                        }
                        try! context.save()
                        try! context.parent?.save()
                    }
                } catch {
                    print("Decoding failed")
                }
                }
            }
        }
        task.resume()
    }
}

