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
 //   var photosRealm = [PhotosRealm]()
    var photoRealm = [PhotoRealm2]()
    func savePhotosData(ownerId:Int, photos: [Photo]){
           do {
               let realm = try Realm()
            //   let oldData = realm.objects(PhotoRealm2.self).filter("ownerId == \(ownerId)")
            let oldLikes = realm.objects(LikeRealm.self)
            let oldReposts = realm.objects(RepostRealm.self)
            let oldSizes = realm.objects(PhotoSizesRealm.self)
               realm.beginWrite()
            var photosToAdd = [PhotoRealm2]()
           
            photos.forEach{photo in
             let photosRealm = PhotoRealm2()
                photosRealm.id = photo.id
                photosRealm.albumId = photo.id
                photosRealm.ownerId = photo.ownerId
                photosRealm.date = photo.date
                photosRealm.text = photo.text
                photosRealm.sizes.append(objectsIn: photo.sizes.map{$0.toRealm()})
                photosRealm.likes = photo.likes.toRealm()
                photosRealm.reposts = photo.reposts.toRealm()
                photosToAdd.append(photosRealm)
            }
           /*    var photosToAdd = [PhotosRealm]()
               photos.forEach{photo in
                   let photosRealm = PhotosRealm()
                   photosRealm.id = photo.id
                   photosRealm.albumId = photo.albumId
                   photosRealm.ownerId = photo.ownerId
                photosRealm.url = photo.sizes.first(where: {$0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"})?.url ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg"
                //   photosRealm.type = photo.type
                photosRealm.text = photo.text
              
               //    photosRealm.userLikes = photo.userLikes
                photosRealm.countLikes = photo.likes.count
              //  photosRealm.countReposts = photo.countReposts
                //   photosRealm.realOffset = photo.realOffset
                   photosToAdd.append(photosRealm)
                }*/
            realm.delete(oldLikes)
            realm.delete(oldReposts)
            realm.delete(oldSizes)
                realm.add(photosToAdd,update: .modified)
                try realm.commitWrite()
             } catch {
               print(error)
               }
    }
    
    func getPhotosData(ownerId:Int) throws -> Results<PhotoRealm2> {
           do {
               let realm = try Realm()
               return realm.objects(PhotoRealm2.self).filter("ownerId == \(ownerId)")
           } catch {
               throw error
             }
    }
    func getPhotosId(imageId: Int) throws -> Results<PhotoRealm2> {
         do {
                      let realm = try Realm()
                      return realm.objects(PhotoRealm2.self).filter("id == \(imageId)")
                  } catch {
                      throw error
                    }
    }
}
