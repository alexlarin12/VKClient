//
//  NewsTextTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 14.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {

    @IBOutlet weak var NewsTextLabel: UILabel!
  //  @IBOutlet weak var NewsTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
