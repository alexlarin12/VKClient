//
//  Session.swift
//  VKClient
//
//  Created by Alex Larin on 11.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
class Session {
   static let instance = Session()
    private init(){}
    var token:String = ""
    var userId:Int = 0
}
