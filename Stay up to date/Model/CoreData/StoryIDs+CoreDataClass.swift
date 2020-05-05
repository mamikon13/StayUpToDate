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
    
    func addStoryIDs(storyIDs: [Int], with type: SourceType) {
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
    
    func getStoryIDs(with type: SourceType) -> [EntityID]? {
        switch type {
        case .newstories:
            return new
        case .topstories:
            return top
        case .beststories:
            return best
        default:
            return nil
        }
    }

}
