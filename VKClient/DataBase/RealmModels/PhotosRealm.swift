//
//  PhotosRealm.swift
//  VKClient
//
//  Created by Alex Larin on 29.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class PhotosRealm:Object{
    @objc dynamic var id:Int = 0
    @objc dynamic var albumId:Int = 0
    @objc dynamic var ownerId:Int = 0
    @objc dynamic var url:String = ""
    @objc dynamic var type:String = ""
    @objc dynamic var text:String = ""
    @objc dynamic var userLikes:Int = 0
    @objc dynamic var countLikes:Int = 0
    @objc dynamic var countReposts:Int = 0
    @objc dynamic var realOffset:Int = 0
    @objc dynamic var date:Int = 0
    
     override class func primaryKey() -> String? {
                 return "id"
    }
 
}
