//
//  NSManagedObject + extensions.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import Foundation
import CoreData

extension NSManagedObject {
    static var entityName: String {
        return self.description()
    }
}
