//
//  StoryID+CoreDataProperties.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData


extension StoryID {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryID> {
        return NSFetchRequest<StoryID>(entityName: StoryID.description())
    }

    @NSManaged public var id: Int64
    @NSManaged public var storyDAO: StoryDAO?

}
