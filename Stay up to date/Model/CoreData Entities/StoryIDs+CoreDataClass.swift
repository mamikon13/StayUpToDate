//
//  StoryIDs+CoreDataClass.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StoryIDs)
public class StoryIDs: NSManagedObject { }


extension StoryIDs: ManagedObjectExistable {
    
    class func getOrCreateSingle() -> StoryIDs {
        if let item = NewsDAL.get(self).first {
            return item
        }

        let item = NewsDAL.shared.createManaged(self)
        return item
    }
    
}


extension StoryIDs {
    
    /// Adds array of story'es IDs of SourceType type to current object.
    ///
    /// - Parameters:
    ///   - storyIDs: The added array of story'es IDs.
    ///   - type: The type of stories.
    func add(storyIDs: [Int], with type: SourceType) {
        let arrayIDs = storyIDs.map { EntityID.getOrCreateSingle(id: $0) }
        
        switch type {
        case .newstories:
            new = arrayIDs
        case .topstories:
            top = arrayIDs
        case .beststories:
            best = arrayIDs
        default:
            return
        }
        
        NewsDAL.shared.saveContext()
    }

}
