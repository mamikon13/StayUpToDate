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

    class func getStoryIDs() -> StoryIDs? {
        return NewsDAL.getOrCreateSingle(self)
    }

}
