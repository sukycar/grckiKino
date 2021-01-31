//
//  Draw+CoreDataProperties.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//
//

import Foundation
import CoreData


extension Draw {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Draw> {
        return NSFetchRequest<Draw>(entityName: "Draw")
    }

    @NSManaged public var drawBreak: Int64
    @NSManaged public var drawId: Int64
    @NSManaged public var drawTime: Int64
    @NSManaged public var gameId: Int64
    @NSManaged public var status: String?
    @NSManaged public var visualDraw: Int64
    @NSManaged public var drawSelected: Bool

}

extension Draw : Identifiable {

}
