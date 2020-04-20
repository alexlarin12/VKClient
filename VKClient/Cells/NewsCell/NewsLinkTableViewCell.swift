//
//  NewsLinkTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 30.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class NewsLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var LinkImageView: UIImageView!
    @IBOutlet weak var TextLinkLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
