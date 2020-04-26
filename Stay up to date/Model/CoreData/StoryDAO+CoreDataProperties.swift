//
//  Story+CoreDataProperties.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData


extension StoryDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryDAO> {
        return NSFetchRequest<StoryDAO>(entityName: StoryDAO.description())
    }

    @NSManaged public var author: String?
    @NSManaged public var time: Date?
    @NSManaged public var title: String?
    @NSManaged public var url: URL?
    @NSManaged public var id: StoryID?
    
}
