//
//  FeedTableViewCell.swift
//  VKtest
//
//  Created by Sunrizz on 06/03/2019.
//  Copyright © 2019 Алексей Усанов. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var repostsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
