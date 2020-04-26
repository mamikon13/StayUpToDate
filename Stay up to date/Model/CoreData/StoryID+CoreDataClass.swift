//
//  StoryID+CoreDataClass.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StoryID)
public class StoryID: NSManagedObject {

    class func getStoryID() -> StoryID? {
        return NewsDAL.getOrCreateSingle(self)
    }
    
}
