//
//  FriendRealm.swift
//  VKClient
//
//  Created by Alex Larin on 29.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class FriendRealm:Object{
    
    @objc dynamic var id:Int = 0
    @objc dynamic var firstName:String = ""
    @objc dynamic var lastName:String = ""
    @objc dynamic var isClosed:Bool = true
    @objc dynamic var canAccessClosed:Bool = true
    @objc dynamic var photo50:String = ""
    @objc dynamic var online:Int = 0
    @objc dynamic var trackCode:String = ""
    
     override class func primaryKey() -> String? {
           return "id"
       }
    
}
