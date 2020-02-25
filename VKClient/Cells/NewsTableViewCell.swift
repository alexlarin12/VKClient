//
//  NewsTableViewCell.swift
//  VKClient
//
//  Created by Alex Larin on 14.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    var likeButton = 547
    @IBOutlet weak var ShadowView: UIView!
    @IBOutlet weak var NewsAvatarImageView: UIImageView!
    @IBOutlet weak var NewsMakerLabel: UILabel!
    @IBOutlet weak var DataNewsLabel: UILabel!
    @IBOutlet weak var NewsTextView: UITextView!
    @IBOutlet weak var NewsImageView: UIImageView!
    @IBOutlet weak var LikeButtonView: UIView!
    @IBOutlet weak var NewsCountLabel: UILabel!
    @IBOutlet weak var NewsComments: UIButton!
    @IBOutlet weak var NewsReposts: UIButton!
    @IBOutlet weak var NewsViews: UIButton!
    
    @IBAction func NewsLikeButtonTap(_ sender: LikeButtonRed) {
        likeButton += 1
        NewsCountLabel.text = "\(likeButton)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
