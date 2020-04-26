//
//  EntityID+CoreDataProperties.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData


extension EntityID {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityID> {
        return NSFetchRequest<EntityID>(entityName: EntityID.description())
    }

    @NSManaged public var selfID: Int64
    @NSManaged public var storyDAO: StoryDAO?

}
