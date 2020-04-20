//
//  UserRepository.swift
//  VKClient
//
//  Created by Alex Larin on 04.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class UserRepository{
     var userRealm = [UserRealm]()
     func saveUserData(user: [ResponseUser]){
           do {
               let realm = try Realm()
            var userToAdd = [UserRealm]()
               realm.beginWrite()
            let userRealm = UserRealm()
            user.forEach { user in
                userRealm.id = user.id
                userRealm.firstName = user.firstName
                userRealm.lastName = user.lastName
                userRealm.isClosed = user.isClosed
                userRealm.canAccessClosed = user.canAccessClosed
                userRealm.photo50 = user.photo50
                userToAdd.append(userRealm)
            }
               realm.add(userToAdd, update: .modified)
               try realm.commitWrite()
      //         print(try! Realm().configuration.fileURL!)
           } catch {
               print(error)
           }
       }
       func getUserData() -> Array<UserRealm>{
           do {
               let realm = try Realm()
               let userFromRealm = realm.objects(UserRealm.self)
               userRealm = Array(userFromRealm)
           } catch {
               print(error)
           }
        return userRealm
       }
}
