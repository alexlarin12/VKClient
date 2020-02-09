//
//  SaveRealmData.swift
//  VKClient
//
//  Created by Alex Larin on 22.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift
class UseRealmData{
    var friendRealm = [FriendRealm]()
    var groupRealm = [GroupRealm]()
    var photosRealm = [PhotosRealm]()
    var userRealm = [UserRealm]()
    
    func saveFriendData(friends: [FriendRealm]){
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded:true)
            let realm = try Realm(configuration: config)
            let oldData = realm.objects(FriendRealm.self)
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func getFriendData(){
        do {
            let realm = try Realm()
            let friendsFromRealm = realm.objects(FriendRealm.self)
            friendRealm = Array(friendsFromRealm)
        } catch  {
            print(error)
        }
    }
    func saveGroupData(groups: [GroupRealm]){
        do {
            let realm = try Realm()
            let oldData = realm.objects(GroupRealm.self)
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(groups)
            try realm.commitWrite()
        } catch  {
            print(error)
        }
    }
    func getGroupData(){
        do {
            let realm = try Realm()
            let groupsFromRealm = realm.objects(GroupRealm.self)
            groupRealm = Array(groupsFromRealm)
        } catch {
            print(error)
        }
    }
    func savePhotosData(ownerId:Int, photos: [PhotosRealm]){
        do {
            let realm = try Realm()
            let oldData = realm.objects(PhotosRealm.self).filter("ownerId == \(ownerId)")
            realm.beginWrite()
            realm.delete(oldData)
            print(photos.count)
            realm.add(photos)
            print(photos.count)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func getPhotosData(ownerId:Int){
        do {
            let realm = try Realm()
            let photosFromRealm = realm.objects(PhotosRealm.self).filter("ownerId == \(ownerId)")
            photosRealm = Array(photosFromRealm)
           
        } catch {
            print(error)
        }
    }
    func saveUserData(user: [UserRealm]){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(user)
            try realm.commitWrite()
            print(try! Realm().configuration.fileURL!)
            
        } catch {
            print(error)
        }
    }
    func getUserData(completion: @escaping ([UserRealm]) ->()){
        do {
            let realm = try Realm()
            let userFromRealm = realm.objects(UserRealm.self)
            userRealm = Array(userFromRealm)
            completion(userRealm)
        } catch {
            print(error)
        }
    }
}
