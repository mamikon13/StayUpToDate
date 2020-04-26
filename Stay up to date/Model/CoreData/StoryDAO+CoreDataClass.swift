//
//  StoryDAO+CoreDataClass.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 25.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Story)
public class StoryDAO: NSManagedObject {

    class func getStoryDAO() -> StoryDAO? {
        return NewsDAL.getOrCreateSingle(self)
    }
        
}


extension StoryDAO: EntityConvertible {
    
    func toEntity() -> Story? {
        return Story(id: id!.id, title: title, author: author, time: time, url: url)
    }
    
}
