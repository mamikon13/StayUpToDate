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
    
    func addStoryIDs(storyIDs: [Int64], to type: SourceType) {
        let array = storyIDs.map { EntityID.getOrCreateSingle(with: $0) }
        let set = NSSet(object: array)
        
        switch type {
        case .newstories:
            addToNew(set)
        case .topstories:
            addToTop(set)
        case .beststories:
            addToBest(set)
        default:
            return
        }
    }

}
