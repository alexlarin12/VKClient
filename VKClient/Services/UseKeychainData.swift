//
//  SessionKeychain.swift
//  VKClient
//
//  Created by Alex Larin on 01.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
class UseKeychainData{
   private let keychain = KeychainWrapper.standard
    func saveKeychainData(){
        keychain.set("123345", forKey: "token")
        keychain.set(7890, forKey: "id")
    }
    func getKeychainData(){
        let token = keychain.string(forKey: "token")
        let id = keychain.integer(forKey: "id")
            print(token ?? "")
            print(id ?? 0)
    }
}
