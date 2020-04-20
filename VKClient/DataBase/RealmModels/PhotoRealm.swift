//
//  PhotoRealm.swift
//  VKClient
//
//  Created by Alex Larin on 24.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoRealm2: Object {
    @objc dynamic var albumId: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var likes: LikeRealm?
    @objc dynamic var reposts: RepostRealm?
    var sizes = List<PhotoSizesRealm>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // Конвертация типа Realm к обычной модели
 /*   func toModel() -> Photo {
        var sizes = [Size1]()
        
        // Проходим по всем вариантам размеров фотографий
        sizes.forEach { size in
            // Инициализируем значения всех свойств
            let oneSize = Size1(type: size.type,
                               url: size.url,
                               width: size.width,
                               height: size.height)
            // И добавляем каждый вариант в массив вариантов
            sizes.append(oneSize)
        }
    
        // Инициализируем значения для свойств лайка
        let likes = Like(isLiked: self.likes?.isLiked ?? 0, count: self.likes?.count ?? 0)
        let reposts = RepostsPhoto(count: self.reposts?.count ?? 0)
        // Возвращаем модель в нужном формате
        return Photo(
                    id: id,
                    albumId: albumId,
                    ownerId: ownerId,
                    sizes: sizes,
                    likes: likes,
                    reposts: reposts,
                    text: text,
                    date: date)
    }*/
}

class PhotoSizesRealm: Object {
    @objc dynamic var url = ""
    @objc dynamic var type = ""
    @objc dynamic var width = 0
    @objc dynamic var height = 0
}

class LikeRealm: Object {
    @objc dynamic var isLiked = 0
    @objc dynamic var count = 0
    
    enum CodingKeys: String, CodingKey {
        case isLiked = "user_likes"
        case count
    }
}
class RepostRealm: Object {
    @objc dynamic var count = 0
}
