//
//  PhotoRequest.swift
//  VKClient
//
//  Created by Alex Larin on 24.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
struct Photo: Decodable {
    var id: Int
    var albumId: Int
    var ownerId: Int
    var sizes: [Size1]
    var likes: Like
    var reposts: RepostsPhoto
    var text: String
    var date: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
        case likes
        case reposts
        case text
        case date
    }
    func toRealm() -> PhotoRealm2 {
        let photoToRealm = PhotoRealm2()
        photoToRealm.albumId = albumId
        photoToRealm.date = date
        photoToRealm.id = id
        photoToRealm.ownerId = ownerId
        photoToRealm.text = text
        photoToRealm.sizes.append(objectsIn: sizes.map { $0.toRealm() })
        photoToRealm.likes = likes.toRealm()
        return photoToRealm
    }
    
}
struct Size1: Codable {
    let type: TypeEnum
    let url: String
    let width: Int
    let height: Int
    
    enum TypeEnum: String, Codable {
        
        case a = "a"
        case b = "b"
        case c = "c"
        case d = "d"
        case e = "e"
        case k = "k"
        case l = "l"
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"/*
        case s = "s"
        case m = "m"
        case x = "x" 
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case y = "y"
        case z = "z"
        case w = "w"*/
    }
    func toRealm() -> PhotoSizesRealm {
        let photoRealm = PhotoSizesRealm()
        photoRealm.url = url
        photoRealm.type = type.rawValue
        photoRealm.width = width
        photoRealm.height = height
        return photoRealm
    }
    
}

struct Like: Decodable {
    var isLiked: Int
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case isLiked = "user_likes"
        case count
    }
    
    func toRealm() -> LikeRealm {
        let likeRealm = LikeRealm()
        likeRealm.count = count
        likeRealm.isLiked = isLiked
        return likeRealm
    }
}
struct RepostsPhoto: Decodable {
    var count: Int
    enum CodingKeys: String, CodingKey {
        case count
    }
     func toRealm() -> RepostRealm {
           let repostRealm = RepostRealm()
           repostRealm.count = count
           return repostRealm
       }
    
}
