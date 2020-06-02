//
//  FriendOnePhotoCell.swift
//  VKClient
//
//  Created by Alex Larin on 07.04.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class FriendOnePhotoCell: UICollectionViewCell {

    @IBOutlet weak var FriendPhotoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    override func prepareForReuse() {
           super.prepareForReuse()
           self.FriendPhotoImageView.image = nil
    }
    
}
