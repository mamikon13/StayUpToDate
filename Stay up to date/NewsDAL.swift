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

    /// All objects of given type in DataBase
    ///
    /// - Parameters:
    ///   - ttype: The type of receiving objects.
    static func get<T: NSManagedObject>(_ ttype: T.Type) -> [T] {
        var result = [T]()
//        let semaphore = DispatchSemaphore(value: 0)
//
//        DispatchQueue.global().async {
            self.shared.managedObjectContext.performAndWait {
                do {
                    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: ttype.description())
                    result = try self.shared.managedObjectContext.fetch(fetchRequest)
                } catch {
                    fatalError("Fetch task failed")
                }
            }
//            semaphore.signal()
//        }
//
//        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }

    func createManaged<T: NSManagedObject>(_ ttype: T.Type) -> T {
        return T(context: managedObjectContext)
    }
    
    
    // MARK: - Core Data stack
    
//    private lazy var backgroundContext: NSManagedObjectContext = {
//        return self.privateManagedObjectContext
//    }()
//
//    private lazy var context: NSManagedObjectContext = {
//        return persistentContainer.viewContext
//    }()
//
//    lazy var currentContext = {
//        return Thread.current.isMainThread ? context : backgroundContext
//    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
//    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
//        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
//        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
//        //managedObjectContext.parent = context
//        return managedObjectContext
//    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
