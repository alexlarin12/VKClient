//
//  NewsGroupsTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 05.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class NewsGroupsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var NewsGroupsAvatar: CircleImageView!
    
    @IBOutlet weak var NewsGroupsLabel: UILabel!
    
    @IBOutlet weak var NewsGroupsDataLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
