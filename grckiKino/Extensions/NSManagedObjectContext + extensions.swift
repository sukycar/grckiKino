//
//  NSManagedObjectContext + extensions.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import UIKit
import CoreData



extension NSManagedObjectContext{

    
    func get<T>(predicate:NSPredicate?) -> T? where T : NSManagedObject{
        let request = T.self.fetchRequest()
        request.predicate = predicate
        var object:T?
        self.performAndWait {
            object = (try? self.fetch(request).first) as? T ?? nil
        }
        return object
    }
    
    func getList<T>(predicate:NSPredicate?, sort:[NSSortDescriptor]?) -> [T]? where T : NSManagedObject{
        let request = T.self.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sort
        var objects:[T]?
        self.performAndWait {
            objects = (try? self.fetch(request))  as? [T] ?? nil
        }
        return objects
    }
    
    func create<T>() -> T? where T : NSManagedObject{
        let entity = NSEntityDescription.entity(forEntityName: T.entityName, in: self)!
        var data:T?
        self.performAndWait {
            data = (NSManagedObject(entity: entity, insertInto: self) as? T) ?? nil

        }
        return data
    }
    
    func create<T>(object:(T?)->Void) -> T? where T : NSManagedObject{
        let entity = NSEntityDescription.entity(forEntityName: T.entityName, in: self)!
        var data:T?
        self.performAndWait {
            data = (NSManagedObject(entity: entity, insertInto: self) as? T) ?? nil
            object(data)
        }
        return data
    }
    func update<T>(predicate:NSPredicate?) -> T? where T : NSManagedObject{
        var itemToReturn:T?
        self.performAndWait {
            if let item:T = self.get(predicate: predicate){
                itemToReturn = item
            }else if let item:T = create(){
                itemToReturn = item
            }
        }
        return itemToReturn
    }
    func update<T>(predicate:NSPredicate?, object:(T?)->Void) -> T? where T : NSManagedObject{
        var itemToReturn:T?
        self.performAndWait {
            if let item:T = self.get(predicate: predicate){
                itemToReturn = item
            }else if let item:T = create(){
                itemToReturn = item
            }
            object(itemToReturn)
        }
        return itemToReturn
    }
    
    
    func delete<T>(fetchRequest: NSFetchRequest<T>, predicate:NSPredicate?) where T : NSManagedObject{
        self.performAndWait {
            if let objects:[T] = self.getList(predicate: predicate, sort: nil) {
                objects.forEach({ (object) in
                    self.delete(object)
                })
            }
        }
    }
}
