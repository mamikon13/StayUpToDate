//
//  Request.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 07.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


enum SourceType {
    case newstories, topstories, beststories, story(Int)
    
    init? (by index: Int) {
        switch index {
        case 0: self = .topstories
        case 1: self = .newstories
        case 2: self = .beststories
        default: return nil
        }
    }
}


struct Request {
    
    private var type: SourceType
    
    private let prefixURL = URL(string: "https://hacker-news.firebaseio.com/v0/")!
    
    init(type: SourceType) {
        self.type = type
    }
    
    var absolutURL: URL {
        switch type {
        case .newstories:
            return prefixURL.appendingPathComponent("newstories.json")
        case .topstories:
            return prefixURL.appendingPathComponent("topstories.json")
        case .beststories:
            return prefixURL.appendingPathComponent("beststories.json")
        case .story(let id):
            return prefixURL.appendingPathComponent("item/\(id).json")
        }
    }
    
}
