//
//  SaveRealmData.swift
//  VKClient
//
//  Created by Alex Larin on 22.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift
class SaveRealmData{
    func saveFriendData(friends: [ItemsFriend]){
        do {
           let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func saveGroupData(groups: [ItemsGroup]){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groups)
            try realm.commitWrite()
        } catch  {
            print(error)
        }
    }
    func savePhotosData(photos: [ItemsPhotos]){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photos)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func saveUserData(user: [ResponseUser]){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(user)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
