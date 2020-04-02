//
//  NewsFooterTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 14.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class NewsFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var LikeNews: LikeButtonRed!
    
    @IBOutlet weak var LikeCountNews: UILabel!
    
    @IBOutlet weak var CommentsCountNews: UIButton!
    
    @IBOutlet weak var RepostsCountNews: UIButton!
    
    @IBOutlet weak var EyeCountNews: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
