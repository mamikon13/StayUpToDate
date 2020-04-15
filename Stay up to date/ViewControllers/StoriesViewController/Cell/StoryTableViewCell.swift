//
//  StoryTableViewCell.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 09.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit

final class StoryTableViewCell: UITableViewCell, BaseTableViewCell {
    
    typealias Element = Story
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var shortURL: UILabel!
    @IBOutlet private weak var byLabel: UILabel!
    
    func setupCell(with story: Story) {
        title.text = story.title
        author.text = story.by
        time.text = String(date: story.time, format: "HH:mm")
        shortURL.text = story.url?.host
        
        if story.by == nil {
            byLabel.isHidden = true
        }
    }
    
    func resetCell() {
        title.text = "Loading..."
        author.text = "Loading..."
        time.text = "•••"
        shortURL.text = "•••"
    }
    
}
