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
    
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the store by given id.
    static func getOrCreateSingle(id: Int) -> ManagedObject
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the store.
    static func getOrCreateSingle() -> ManagedObject
    
    /// Gets a NSManagedObject from the CoreData if it exists in the store by given id.
    static func getSingle(id: Int) -> ManagedObject?
    
    /// Gets a NSManagedObject from the CoreData if it exists in the store by given ordinal.
    static func getSingle(ordinal: Int16) -> ManagedObject?
    
}


extension ManagedObjectExistable {
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the store by given id.
    static func getOrCreateSingle(id: Int) -> ManagedObject {
        return NewsDAL.shared.createManaged(self) as! Self.ManagedObject
    }
    
    /// Creates a NSManagedObject from the CoreData or gets if it exists in the store.
    static func getOrCreateSingle() -> ManagedObject {
        return NewsDAL.shared.createManaged(self) as! Self.ManagedObject
    }
    
    /// Gets a NSManagedObject from the CoreData if it exists in the store by given id.
    static func getSingle(id: Int) -> ManagedObject? {
        return nil
    }
    
    /// Gets a NSManagedObject from the CoreData if it exists in the store by given ordinal.
    static func getSingle(ordinal: Int16) -> ManagedObject? {
        return nil
    }
    
}


extension ManagedObjectExistable where ManagedObject: EntityConvertible {
    
    /// Gets a NSManagedObject that conforms to EntityConvertible from the CoreData if it exists in the store by given ordinal.
    static func getSingle(ordinal: Int16) -> ManagedObject? {
        return nil
    }
        
        /// Gets a NSManagedObject that conforms to EntityConvertible from the CoreData if it exists in the store by given ordinal.
    //    static func getSingle<T>(ordinal: Int16) -> T? where T: EntityConvertible {
    //        return nil
    //    }
    
}
