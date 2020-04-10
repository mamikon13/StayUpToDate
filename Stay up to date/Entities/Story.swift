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
    let by: String?
    let time: Date?
    let url: URL?
    
    private(set) var type: StoryType?
    private var storyType: String? {
        willSet {
            self.type = StoryType(string: newValue)
        }
    }
    
}


extension Story: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case by
        case time
        case url
        case storyType = "type"
    }
    
}
