//
//  PostListTableViewCell.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

class PostListTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    func configure(with post: PostModel) {
        postTitleLabel.text = post.title
        postDateLabel.text = post.dateString
    }
    
    class func height(with post: PostModel) -> CGFloat {
        let textWidth = UIScreen.main.bounds.width - 15*2
        let verticalMargins = CGFloat(10*2 + 8) + 1

        let titleHeight = post.title.tn_height(with: UIFont.systemFont(ofSize: 16), width: textWidth)
        let dateHeight = post.dateString.tn_height(with: UIFont.systemFont(ofSize: 14), width: textWidth)
        
        return titleHeight + verticalMargins + dateHeight
    }
}
