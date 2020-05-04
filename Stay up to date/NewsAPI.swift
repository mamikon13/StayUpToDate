//
//  NewsAPI.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 07.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


typealias ApiCallback<T:Decodable> = (_ data: T?, _ error: Error?) -> Void


final class NewsAPI {
    
    static let shared = NewsAPI()
    
    
    private init() { }
    
    
    private func fetch<T: Decodable>(for request: Request, callback: @escaping ApiCallback<T>) -> URLSessionDataTask {
        
        let url = request.absolutURL
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                callback(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if [403,404,500,401].contains(httpResponse.statusCode) {
                    let error = "Info: API Call \(httpResponse.statusCode):\(httpResponse.description):\(url.absoluteString)" as? Error
                    callback(nil, error)
                    return
                }
            }
            
            var parsedData: T? = nil
            
            do {
                parsedData = try JSONDecoder().decode(T.self, from: data!)
            } catch let error {
                callback(nil, error)
                return
            }
            
            callback(parsedData, nil)
        }
        
        task.resume()
        return task
    }
    
}


extension NewsAPI {
    
    func storyIDs(from sourceType: SourceType, callback: @escaping ApiCallback<Set<Int>>) {
        _ = fetch(for: Request(type: sourceType)) { storyIDs, error in
            callback(storyIDs, error)
        }
    }
    
    func story(id: Int, callback: @escaping ApiCallback<Story>) -> URLSessionDataTask {
        fetch(for: Request(type: .story(id))) { story, error in
            callback(story, error)
        }
    }
    
    func stories(from sourceType: SourceType, callback: @escaping ApiCallback<[Story]>) {
        storyIDs(from: sourceType) { storyIDs, error in
            guard let ids = storyIDs else {
                callback(nil, error)
                return
            }
            
            var stories = [Story]()
            for id in ids {
                _ = self.story(id: id) { story, _  in
                    guard let story = story else { return }
                    stories.append(story)
                }
            }
            callback(stories, nil)
        }
    }
    
}
