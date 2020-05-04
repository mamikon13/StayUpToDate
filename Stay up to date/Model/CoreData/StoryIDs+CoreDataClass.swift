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
public class StoryIDs: NSManagedObject {
    
    class func getOrCreateSingle() -> StoryIDs {
        if let item = NewsDAL.get(self).first {
            return item
        }
        
        let item = NewsDAL.shared.createManaged(self)
        return item
    }
    
    func addStoryIDs(storyIDs: Set<Int>, with type: SourceType) {
        let arrayIDs = Set(storyIDs.map { EntityID.getOrCreateSingle(with: $0) })
        
        switch type {
        case .newstories:
            new = arrayIDs as NSSet
//            addToNew(arrayIDs as NSSet)
        case .topstories:
            top = arrayIDs as NSSet
//            addToTop(arrayIDs as NSSet)
        case .beststories:
            best = arrayIDs as NSSet
//            addToBest(arrayIDs as NSSet)
        default:
            return
        }
        NewsDAL.shared.saveContext()
    }
    
    func getStoryIDs(with type: SourceType) -> Set<EntityID>? {
        switch type {
        case .newstories:
            return new as? Set<EntityID>
        case .topstories:
            return top as? Set<EntityID>
        case .beststories:
            return best as? Set<EntityID>
        default:
            return nil
        }
    }

}
