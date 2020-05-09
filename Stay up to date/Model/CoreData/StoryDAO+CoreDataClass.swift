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
        let format = "id.selfID = \(id)"
        if let item = NewsDAL.get(self, with: format).first {
            return item
        }
        
        let entityID = EntityID.getOrCreateSingle(id: id)
        let item = NewsDAL.shared.createManaged(self)
        item.id = entityID
        return item
    }
    
    class func getSingle(id: Int) -> StoryDAO? {
        let format = "id.selfID = \(id)"
        return NewsDAL.get(self, with: format).first
    }
    
}


extension StoryDAO: EntityConvertible {
    
    func toEntity() -> Story {
        return Story(id: id.selfID, title: title, author: author, time: time, url: url)
    }
    
}
