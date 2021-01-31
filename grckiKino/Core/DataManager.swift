//
//  DataManager.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//
import CoreData
import UIKit

final class DataManager {
    static let shared: DataManager = .init()
    lazy private(set) var context: NSManagedObjectContext! = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    func work(update:@escaping ((_ context:NSManagedObjectContext)-> Void)){
        DispatchQueue.main.async {
            (UIApplication.shared.delegate as! AppDelegate).persistentContainer.performBackgroundTask { (context) in
                update(context)
            }
        }
    }
    
}
