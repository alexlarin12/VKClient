//
//  FriendsRepository.swift
//  VKClient
//
//  Created by Alex Larin on 04.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class FriendsRepositiry{
    
     var friendRealm = [FriendRealm]()
    
     func saveFriendData(friends: [ItemsFriend]){
           do {
               let config = Realm.Configuration(deleteRealmIfMigrationNeeded:false)
               let realm = try Realm(configuration: config)
               realm.beginWrite()
       //    realm.deleteAll()
                  var friendsToAdd = [FriendRealm]()
                  friends.forEach { friend in
                      let friendRealm = FriendRealm()
                      friendRealm.id = friend.id
                      friendRealm.firstName = friend.firstName
                      friendRealm.lastName = friend.lastName
                      friendRealm.isClosed = friend.isClosed ?? false
                      friendRealm.canAccessClosed = friend.canAccessClosed ?? true
                      friendRealm.photo50 = friend.photo50 
                      friendRealm.online = friend.online
                      friendRealm.trackCode = friend.trackCode 
                      friendsToAdd.append(friendRealm)
                  }
               realm.add(friendsToAdd, update: .modified)
               try realm.commitWrite()
            print(try! Realm().configuration.fileURL!)
            
           } catch {
               print(error)
           }
    }
    func getFriendData() throws-> Results<FriendRealm> {
           do {
               let realm = try Realm()
               return realm.objects(FriendRealm.self)
           } catch  {
               throw error
           }
    }
    func searchFriends(lastName: String) throws -> Results<FriendRealm> {
            do {
                 let realm = try Realm()
                 return realm.objects(FriendRealm.self).filter("lastName CONTAINS[c] %@", lastName)
            } catch {
                 throw error
            }
    }
}
