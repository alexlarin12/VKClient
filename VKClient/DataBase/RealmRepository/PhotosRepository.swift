//
//  PhotosRepository.swift
//  VKClient
//
//  Created by Alex Larin on 04.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift
class PhotosRepository{
    var photosRealm = [PhotosRealm]()
    func savePhotosData(ownerId:Int, photos: [ItemsPhotos]){
           do {
               let realm = try Realm()
             //  let oldData = realm.objects(PhotosRealm.self).filter("ownerId == \(ownerId)")
               realm.beginWrite()
               var photosToAdd = [PhotosRealm]()
               photos.forEach{photo in
                   let photosRealm = PhotosRealm()
                   photosRealm.id = photo.id
                   photosRealm.albumId = photo.albumId
                   photosRealm.ownerId = photo.ownerId
                   photosRealm.url = photo.url
                   photosRealm.text = photo.text
                   photosRealm.userLikes = photo.userLikes
                   photosRealm.countLikes = photo.countLikes
                   photosRealm.countReposts = photo.countReposts
                   photosRealm.realOffset = photo.realOffset
                   photosToAdd.append(photosRealm)
                }
                realm.add(photosToAdd,update: .modified)
                try realm.commitWrite()
             } catch {
               print(error)
               }
    }
    
    func getPhotosData(ownerId:Int) throws -> Results<PhotosRealm> {
           do {
               let realm = try Realm()
               return realm.objects(PhotosRealm.self).filter("ownerId == \(ownerId)")
           } catch {
               throw error
             }
    }
}
