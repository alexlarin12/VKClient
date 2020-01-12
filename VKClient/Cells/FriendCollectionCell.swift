//
//  FriendCollectionCell.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class FriendCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var FriendImageView: UIImageView!
    
    @IBOutlet weak var LikeCountLabel: UILabel!
    
    @IBOutlet weak var LikeButton: LikeButtonRed!
    var likeCount = 0
    var likeUseCount = 0
    
    @IBAction func LikeButtonTap(_ sender: LikeButtonRed) {
        
        if likeCount - likeUseCount >= 1{
            likeCount = likeCount-1
            LikeCountLabel.text = "\(likeCount)"
        }else{
            likeCount = likeUseCount+1
            LikeCountLabel.text = "\(likeCount)"
        }
    }
}
