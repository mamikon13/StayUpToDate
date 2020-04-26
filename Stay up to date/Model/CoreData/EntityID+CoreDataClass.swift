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

@objc(StoryID)
public class EntityID: NSManagedObject {
    
    class func getOrCreateSingle(with id: Int64) -> EntityID {
        if let item = NewsDAL.get(self).first(where: { $0.selfID == id }) {
            return item
        }
        
        let item = NewsDAL.shared.createManaged(self)
        item.selfID = id
        return item
    }
    
}
