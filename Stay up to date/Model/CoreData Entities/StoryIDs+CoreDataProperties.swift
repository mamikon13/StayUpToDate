//
//  StoryIDs+CoreDataProperties.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData


extension StoryIDs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryIDs> {
        return NSFetchRequest<StoryIDs>(entityName: StoryIDs.description())
    }

    @NSManaged public var best: [EntityID]?
    @NSManaged public var new: [EntityID]?
    @NSManaged public var top: [EntityID]?

}
