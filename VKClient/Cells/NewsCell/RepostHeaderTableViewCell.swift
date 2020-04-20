//
//  RepostHeaderTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 17.04.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class RepostHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var RepostAvatarImageView: CircleImageView!
    
    
    @IBOutlet weak var RepostNameButton: UIButton!
    @IBOutlet weak var RepostDataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
