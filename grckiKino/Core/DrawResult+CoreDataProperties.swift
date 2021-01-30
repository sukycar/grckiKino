//
//  DrawResult+CoreDataProperties.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//
//

import Foundation
import CoreData


extension DrawResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrawResult> {
        return NSFetchRequest<DrawResult>(entityName: "DrawResult")
    }

    @NSManaged public var drawId: Int64
    @NSManaged public var drawTime: Int64
    @NSManaged public var gameId: Int64
    @NSManaged public var list: NSObject?

}

extension DrawResult : Identifiable {

}
