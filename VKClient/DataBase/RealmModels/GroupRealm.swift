//
//  GroupRealm.swift
//  VKClient
//
//  Created by Alex Larin on 29.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRealm:Object{
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var screenName:String = ""
    @objc dynamic var isClosed:Int = 0
    @objc dynamic var type:String = ""
    @objc dynamic var isAdmin:Int = 0
    @objc dynamic var isMember:Int = 0
    @objc dynamic var isAdvertiser:Int = 0
    @objc dynamic var site:String = ""
    @objc dynamic var photo50:String = ""
    @objc dynamic var photo100:String = ""
    @objc dynamic var photo200:String = ""
    
    override class func primaryKey() -> String? {
              return "id"
          }
    
}
