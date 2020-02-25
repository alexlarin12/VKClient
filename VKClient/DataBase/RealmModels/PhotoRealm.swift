//
//  PhotoRealm.swift
//  VKClient
//
//  Created by Alex Larin on 24.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoRealm: Object {
    @objc dynamic var albumId = 0
    @objc dynamic var date = 0
    @objc dynamic var id = 0
    @objc dynamic var ownerId = 0
    @objc dynamic var text: String?
    var likes: LikeRealm?
    var sizes = List<PhotoSizesRealm>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // Конвертация типа Realm к обычной модели
    func toModel() -> Photo {
        var sizes = [Size]()
        
        // Проходим по всем вариантам размеров фотографий
        sizes.forEach { size in
            // Инициализируем значения всех свойств
            let oneSize = Size(type: size.type,
                               url: size.url,
                               width: size.width,
                               height: size.height)
            // И добавляем каждый вариант в массив вариантов
            sizes.append(oneSize)
        }
    
        // Инициализируем значения для свойств лайка
        let likes = Like(isLiked: self.likes?.isLiked ?? 0, count: self.likes?.count ?? 0)
        
        // Возвращаем модель в нужном формате
        return Photo(
                    id: id,
                    albumId: albumId,
                    ownerId: ownerId,
                    sizes: sizes,
                    likes: likes)
    }
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
