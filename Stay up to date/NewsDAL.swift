//
//  NewsDAL.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation
import CoreData


final class NewsDAL {
    
    // MARK: - Singletone
    
    static let shared = NewsDAL()
    
    private init() { }
    
    
    // MARK: internal stuff

    /// All objects by the given type in DataBase
    ///
    /// - Parameters:
    ///   - ttype: The type of receiving objects.
    ///   - NSPredicateFormat: The format string of optional NSPredicate.
    static func get<T: NSManagedObject>(_ ttype: T.Type, with NSPredicateFormat: String? = nil) -> [T] {
        var result = [T]()
        let semaphore = DispatchSemaphore(value: 0)

        DispatchQueue.global().async {
            self.shared.backgroundContext.performAndWait {
                
                let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: ttype.description())
                fetchRequest.predicate = NSPredicateFormat != nil ? NSPredicate(format: NSPredicateFormat!) : nil
                
                do {
                    result = try self.shared.backgroundContext.fetch(fetchRequest)
                } catch {
                    fatalError("Fetch task failed")
                }
            }
            semaphore.signal()
        }
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    /// Creates NSManagedObject of the given type
    ///
    /// - Parameters:
    ///   - ttype: The type of creating object.
    func createManaged<T: NSManagedObject>(_ ttype: T.Type) -> T {
        return T(context: backgroundContext)
    }
    
    
    // MARK: - Core Data stack
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            container.viewContext.shouldDeleteInaccessibleFaults = true
            container.viewContext.automaticallyMergesChangesFromParent = true
        })
        
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    public func saveContext() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
