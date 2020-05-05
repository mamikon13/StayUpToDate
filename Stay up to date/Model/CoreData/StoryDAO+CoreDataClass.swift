//
//  StoryDAO+CoreDataClass.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StoryDAO)
public class StoryDAO: NSManagedObject { }


extension StoryDAO: ManagedObjectExistable {
    
    class func getOrCreateSingle(id: Int) -> StoryDAO {
        if let item = NewsDAL.get(self).first(where: { $0.id.selfID == id }) {
            return item
        }
        
        let entityID = EntityID.getOrCreateSingle(id: id)
        let item = NewsDAL.shared.createManaged(self)
        item.id = entityID
        return item
    }
    
    class func getSingle(ordinal: Int16) -> StoryDAO? {
        if let item = NewsDAL.get(self).first(where: { $0.ordinal == ordinal }) {
            return item
        }
        
        return nil
    }
    
}


extension StoryDAO: EntityConvertible {
    
    func toEntity() -> Story {
        return Story(id: id.selfID, title: title, author: author, time: time, url: url)
    }
    
}
