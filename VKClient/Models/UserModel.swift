//
//  UserModel.swift
//  VKClient
//
//  Created by Alex Larin on 15.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift
class UserModel:Decodable{
    let response:[ResponseUser]?
}
class ResponseUser: Decodable{
     var id:Int = 0
     var firstName:String = ""
     var lastName:String = ""
     var isClosed:Bool = true
     var canAccessClosed:Bool = true
     var photo50:String = ""
    enum ResponseUserKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case photo50 = "photo_50"
    }
    
    convenience required init(from decoder:Decoder) throws{
        self.init()
        let values = try decoder.container(keyedBy: ResponseUserKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.isClosed = try values.decode(Bool.self, forKey: .isClosed)
        self.canAccessClosed = try values.decode(Bool.self, forKey: .canAccessClosed)
        self.photo50 = try values.decode(String.self, forKey: .photo50)
    }
 
}
