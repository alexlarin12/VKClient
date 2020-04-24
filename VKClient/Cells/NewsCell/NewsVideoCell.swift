//
//  NewsVideoCell.swift
//  VKClient
//
//  Created by Alex Larin on 22.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher

class NewsVideoCell: UITableViewCell {

    @IBOutlet weak var VideoImage: UIImageView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
/*
func playVideo(){
              let videoURL = URL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!
              let pleer = AVPlayer(url: videoURL)
              let pleerLayer = AVPlayerLayer(player: pleer)
           pleerLayer.frame = self.VideoView.bounds
              pleerLayer.videoGravity = .resizeAspect
              self.VideoView.layer.addSublayer(pleerLayer)
              pleer.play()
          }

*/
