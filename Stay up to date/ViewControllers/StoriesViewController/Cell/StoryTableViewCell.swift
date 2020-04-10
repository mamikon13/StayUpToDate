//
//  StoryTableViewCell.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 09.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell, BaseTableViewCell {
    
    typealias Element = Story
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var shortURL: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    
    func setupCell(with story: Story) {
        title.text = story.title
        author.text = story.by
        time.text = String(date: story.time, format: "HH:mm")
        shortURL.text = story.url?.host
        
        if story.by == nil {
            byLabel.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = "Loading..."
        author.text = "Loading..."
        time.text = "•••"
        shortURL.text = "•••"
    }
    
}
