//
//  Story.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 06.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


enum StoryType {
    
    case job, story, comment, poll, pollopt
    
    var color: UIColor {
        switch self {
        case .job:
            return .yellow
        case .story:
            return .brown
        case .comment:
            return .blue
        case .poll, .pollopt:
            return .green
        }
    }
    
    init? (string: String?) {
        switch string {
        case "job": self = .job
        case "story": self = .story
        case "comment": self = .comment
        case "poll": self = .poll
        case "pollopt": self = .pollopt
        default: return nil
        }
    }
    
}


struct Story {

    let id: Int
    let title: String?
    let author: String?
    let time: Date?
    let url: URL?

    private(set) var type: StoryType?
    private var storyType: String? {
        willSet {
            self.type = StoryType(string: newValue)
        }
    }
    
    public init(id: Int, title: String?, author: String?, time: Date?, url: URL?, storyType: String? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.time = time
        self.url = url
        self.storyType = storyType
    }

}


extension Story: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case author = "by"
        case time
        case url
        case storyType = "type"
    }

}


extension Story: ManagedObjectConvertible {

    func toManagedObject() -> StoryDAO {
        let storyDAO = StoryDAO.getOrCreateSingle(id: id)
        storyDAO.title = title
        storyDAO.author = author
        storyDAO.time = time
        storyDAO.url = url
        
        return storyDAO
    }

}
