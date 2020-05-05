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
        let semaphore = DispatchSemaphore(value: 0)

        DispatchQueue.global().async {
            self.shared.backgroundContext.performAndWait {
                do {
                    if ttype.description() == "StoryDAO" {
//                        fatalError()
                    }
                    let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: ttype.description())
                    result = try self.shared.currentContext.fetch(fetchRequest)
                } catch {
                    fatalError("Fetch task failed")
                }
            }
            semaphore.signal()
        }
//
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }

    func createManaged<T: NSManagedObject>(_ ttype: T.Type) -> T {
        return T(context: currentContext)
    }
    
    
    // MARK: - Core Data stack
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()

    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    lazy var currentContext = {
        return Thread.current.isMainThread ? context : backgroundContext
    }()
    
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
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            container.viewContext.undoManager = nil
            container.viewContext.shouldDeleteInaccessibleFaults = true
            container.viewContext.automaticallyMergesChangesFromParent = true
        })
        
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if currentContext.hasChanges {
            do {
                try currentContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
