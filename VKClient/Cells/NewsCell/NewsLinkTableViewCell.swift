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
    @IBOutlet weak var LinkTitleButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configur(ButtonTitle: String){
           if ButtonTitle == ""  {
              // newsTextHeight.constant = 0
               LinkTitleButton.isHidden = true
           } else {
               LinkTitleButton.isHidden = false
           }
       }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
