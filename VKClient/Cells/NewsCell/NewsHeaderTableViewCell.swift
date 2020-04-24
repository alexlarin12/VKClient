//
//  NewsGroupsTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 05.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class NewsHeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var NewsHeaderAvatar: CircleImageView!
    
    @IBOutlet weak var NewsHeaderLabel: UILabel!
    
    @IBOutlet weak var NewsHeaderDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
