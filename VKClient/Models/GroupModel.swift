//
//  GroupModel.swift
//  VKClient
//
//  Created by Alex Larin on 15.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class ItemsGroup: Decodable{
     var id:Int = 0
     var name:String = ""
     var screenName:String? = ""
     var isClosed:Int? = 0
     var type:String = ""
     var isAdmin:Int = 0
     var isMember:Int = 1
     var isAdvertiser:Int = 0
     var site:String = ""
     var photo50:String = ""
     var photo100:String = ""
     var photo200:String = ""
    
    enum ItemsGroupKeys:String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case site
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
    
    convenience required init(from decoder:Decoder)throws {
        self.init()
        let values = try decoder.container(keyedBy: ItemsGroupKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.screenName = try values.decode(String.self, forKey: .screenName)
        self.isClosed = try values.decode(Int.self, forKey: .isClosed)
        self.type = try values.decode(String.self, forKey: .type)
        self.isAdmin = try values.decode(Int.self, forKey: .isAdmin)
        self.isMember = try values.decode(Int.self, forKey: .isMember)
        self.isAdvertiser = try values.decode(Int.self, forKey: .isAdvertiser)
        self.site = try values.decode(String.self, forKey: .site)
        self.photo50 = try values.decode(String.self, forKey: .photo50)
        self.photo100 = try values.decode(String.self, forKey: .photo100)
        self.photo200 = try values.decode(String.self, forKey: .photo200)
    }
 
}
