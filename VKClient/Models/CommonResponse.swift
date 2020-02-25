//
//  CommonResponse.swift
//  VKClient
//
//  Created by Alex Larin on 26.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import UIKit

class CommonResponse<T:Decodable>: Decodable {
    var response:CommonResponseArray<T>
}
class CommonResponseArray<T:Decodable>: Decodable{
  //  var count:Int
    var items:[T]
}
