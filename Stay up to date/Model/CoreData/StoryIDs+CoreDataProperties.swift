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

    @NSManaged public var best: NSSet?
    @NSManaged public var new: NSSet?
    @NSManaged public var top: NSSet?

}

// MARK: Generated accessors for best
extension StoryIDs {

    @objc(addBestObject:)
    @NSManaged public func addToBest(_ value: EntityID)

    @objc(removeBestObject:)
    @NSManaged public func removeFromBest(_ value: EntityID)

    @objc(addBest:)
    @NSManaged public func addToBest(_ values: NSSet)

    @objc(removeBest:)
    @NSManaged public func removeFromBest(_ values: NSSet)

}

// MARK: Generated accessors for new
extension StoryIDs {

    @objc(addNewObject:)
    @NSManaged public func addToNew(_ value: EntityID)

    @objc(removeNewObject:)
    @NSManaged public func removeFromNew(_ value: EntityID)

    @objc(addNew:)
    @NSManaged public func addToNew(_ values: NSSet)

    @objc(removeNew:)
    @NSManaged public func removeFromNew(_ values: NSSet)

}

// MARK: Generated accessors for top
extension StoryIDs {

    @objc(addTopObject:)
    @NSManaged public func addToTop(_ value: EntityID)

    @objc(removeTopObject:)
    @NSManaged public func removeFromTop(_ value: EntityID)

    @objc(addTop:)
    @NSManaged public func addToTop(_ values: NSSet)

    @objc(removeTop:)
    @NSManaged public func removeFromTop(_ values: NSSet)

}
