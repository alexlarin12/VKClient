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
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
        case likes
    }
}

struct Size1: Codable {
    let type: TypeEnum
    let url: String
    let width: Int
    let height: Int
    
    enum TypeEnum: String, Codable {
        case s = "s" //s — пропорциональная копия изображения с максимальной стороной 75px;
        case m = "m" //m — пропорциональная копия изображения с максимальной стороной 130px;
        case x = "x" //x — пропорциональная копия изображения с максимальной стороной 604px;
        case o = "o" //o — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 130px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева изображения с максимальной шириной 130px и соотношением сторон 3:2.
        case p = "p" //p — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 200px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева и справа изображения с максимальной шириной 200px и соотношением сторон 3:2.
        case q = "q" //q — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 320px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева и справа изображения с максимальной шириной 320px и соотношением сторон 3:2.
        case r = "r" //r — если соотношение "ширина/высота" исходного изображения меньше или равно 3:2, то пропорциональная копия с максимальной шириной 510px. Если соотношение "ширина/высота" больше 3:2, то копия обрезанного слева и справа изображения с максимальной шириной 510px и соотношением сторон 3:2
        case y = "y" //y — пропорциональная копия изображения с максимальной стороной 807px;
        case z = "z" //z — пропорциональная копия изображения с максимальным размером 1080x1024;
        case w = "w" //w — пропорциональная копия изображения с максимальным размером 2560x2048px.
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
