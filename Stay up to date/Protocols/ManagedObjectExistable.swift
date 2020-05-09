//
//  ManagedObjectGettable.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 05.05.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation
import CoreData


protocol ManagedObjectExistable: NSManagedObject {
    
    associatedtype ManagedObject
    
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the persistent store by the given id.
    ///
    /// - Parameters:
    ///   - id: The id of the object that we are going to get.
    static func getOrCreateSingle(id: Int) -> ManagedObject
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the persistent store.
    static func getOrCreateSingle() -> ManagedObject
    
    /// Gets a NSManagedObject from the CoreData if it exists in the persistent store by the given id.
    ///
    /// - Parameters:
    ///   - id: The id of the object that we are going to get.
    static func getSingle(id: Int) -> ManagedObject?
    
}


extension ManagedObjectExistable {
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the persistent store by the given id.
    ///
    /// - Parameters:
    ///   - id: The id of the object that we are going to get.
    static func getOrCreateSingle(id: Int) -> ManagedObject {
        return NewsDAL.shared.createManaged(self) as! Self.ManagedObject
    }
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the persistent store.
    static func getOrCreateSingle() -> ManagedObject {
        return NewsDAL.shared.createManaged(self) as! Self.ManagedObject
    }
    
    /// Gets a NSManagedObject from the CoreData if it exists in the persistent store by the given id.
    ///
    /// - Parameters:
    ///   - id: The id of the object that we are going to get.
    static func getSingle(id: Int) -> ManagedObject? {
        return nil
    }
    
}


extension ManagedObjectExistable where ManagedObject: EntityConvertible {
    
    /// Gets a NSManagedObject that conforms to EntityConvertible from the CoreData if it exists in the persistent store by the given id.
    ///
    /// - Parameters:
    ///   - id: The id of the object that we are going to get. 
    static func getSingle(id: Int) -> ManagedObject? {
        return nil
    }
    
}
