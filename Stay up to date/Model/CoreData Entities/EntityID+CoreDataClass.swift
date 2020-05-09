//
//  EntityID+CoreDataClass.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EntityID)
public class EntityID: NSManagedObject { }


extension EntityID: ManagedObjectExistable {
    
    class func getOrCreateSingle(id: Int) -> EntityID {
        let format = "selfID = \(id)"
        if let item = NewsDAL.get(self, with: format).first {
            return item
        }
        
        let item = NewsDAL.shared.createManaged(self)
        item.selfID = id
        return item
    }
    
}
