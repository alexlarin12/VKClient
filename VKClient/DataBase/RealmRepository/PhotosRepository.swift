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
    //метод сохранения фото в Realm:
    func savePhotosData(ownerId:Int, photos: [Photo]){
        do {
            let realm = try Realm()
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
            realm.delete(oldLikes)
            realm.delete(oldReposts)
            realm.delete(oldSizes)
                realm.add(photosToAdd,update: .modified)
                try realm.commitWrite()
            } catch {
               print(error)
            }
    }
    //метод получения фото из Realm:
    func getPhotosData(ownerId:Int) throws -> Results<PhotoRealm2> {
        do {
            let realm = try Realm()
            return realm.objects(PhotoRealm2.self).filter("ownerId == \(ownerId)")
        } catch {
            throw error
        }
    }
    //метод получения фото из Realm по imageID:
    func getPhotosId(imageId: Int) throws -> Results<PhotoRealm2> {
        do {
            let realm = try Realm()
            return realm.objects(PhotoRealm2.self).filter("id == \(imageId)")
        } catch {
            throw error
        }
    }
}
