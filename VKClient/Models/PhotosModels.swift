//
//  PhotosModels.swift
//  VKClient
//
//  Created by Alex Larin on 18.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import UIKit
class PhotosModel: Decodable {
        let response:ResponsePhotos?
    }
class ResponsePhotos:Decodable{
    var count:Int
    var items:[ItemsPhotos]?
    }
class ItemsPhotos:Decodable{
    var id:Int = 0
    var albumId:Int = 0
    var ownerId:Int = 0
    var url:String = ""
    var text:String = ""
    var userLikes:Int = 0
    var countLikes:Int = 0
    var countReposts:Int? = 0
    var realOffset:Int = 0
    enum ItemsPhotosKeys:String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
        case text
        case likes
        case reposts
        case realOffset = "real_offset"
    }
    enum SizesPhotosKeys:String, CodingKey {
            case url
    }
    enum LikesPhotosKeys:String, CodingKey {
        case userLikes = "user_likes"
        case countLikes = "count"
    }
    enum RepostsPhotosKeys:String, CodingKey{
        case countReposts = "count"
    }
    
    convenience required init(from decoder:Decoder) throws{
        self.init()
        
        let values = try decoder.container(keyedBy: ItemsPhotosKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.albumId = try values.decode(Int.self, forKey: .albumId)
        self.ownerId = try values.decode(Int.self, forKey: .ownerId)
        self.text = try values.decode(String.self, forKey: .text)
       
        var sizesValues = try values.nestedUnkeyedContainer(forKey: .sizes)
        let firstSizesValues = try sizesValues.nestedContainer(keyedBy: SizesPhotosKeys.self)
        self.url = try firstSizesValues.decode(String.self, forKey: .url)
 
        
        let likesValues = try values.nestedContainer(keyedBy: LikesPhotosKeys.self, forKey: .likes)
        self.userLikes = try likesValues.decode(Int.self, forKey: .userLikes)
        self.countLikes = try likesValues.decode(Int.self, forKey: .countLikes)
        
        let repostsValues = try values.nestedContainer (keyedBy:RepostsPhotosKeys.self, forKey: .reposts)
        self.countReposts = try? repostsValues.decode(Int.self, forKey: .countReposts)

    }
    
}
