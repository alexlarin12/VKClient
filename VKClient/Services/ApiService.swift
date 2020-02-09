//
//  VKService.swift
//  VKClient
//
//  Created by Alex Larin on 14.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper
enum RequestError:Error{
    case failedRequest(massage:String)
    case decodableError
}
class ApiService {
    let useRealmData = UseRealmData()
    var usersRealm = [UserRealm]()
    var friendsRealm = [FriendRealm]()
    var groupsRealm = [GroupRealm]()
    var photosRealm = [PhotosRealm]()
    typealias Out = Swift.Result
    private let idFromKeychain = KeychainWrapper.standard.integer(forKey: "id")!
    private let tokenFromKeychain = KeychainWrapper.standard.string(forKey: "token")
    
    func loadFriendsData(completion: @escaping ([FriendRealm]) -> Void){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(idFromKeychain)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: tokenFromKeychain),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else{return}
            do{
            let friends = try JSONDecoder().decode(FriendModel.self, from: data).response?.items
            for friend in friends ?? []{
                let friendRealm = FriendRealm(value: [friend.id, friend.firstName,friend.lastName, friend.isClosed ?? true,friend.canAccessClosed ?? true, friend.photo50,friend.online,friend.trackCode])
                self.friendsRealm.append(friendRealm)
            }
            self.useRealmData.saveFriendData(friends: self.friendsRealm)
                self.useRealmData.getFriendData()
                completion(self.friendsRealm)
            }catch{
                print(error)
            }
        }
    }
    func loadGroupsData(completion: @escaping ([GroupRealm]) -> Void){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value:String(Session.instance.userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "site"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else{return}
            do{
            let groups = try JSONDecoder().decode(GroupModel.self, from: data).response?.items
            for group in groups ?? []{
                let groupRealm = GroupRealm(value: [group.id, group.name,group.screenName, group.isClosed , group.type,group.isAdmin,group.isMember, group.isAdvertiser, group.site, group.photo50,group.photo100, group.photo200])
                self.groupsRealm.append(groupRealm)
                }
                self.useRealmData.saveGroupData(groups: self.groupsRealm)
                self.useRealmData.getGroupData()
                completion(self.groupsRealm)
            }catch{
                    print(error)
                }
        }
    }
    func loadPhotosData(ownerId:Int,completion: @escaping ([PhotosRealm]) -> Void){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(ownerId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else{return}
            do{
            let photos = try JSONDecoder().decode(PhotosModel.self, from: data).response?.items
                for photo in photos ?? []{
                    let photoRealm = PhotosRealm(value: [photo.id, photo.albumId, photo.ownerId, photo.url, photo.text, photo.userLikes, photo.countLikes, photo.countReposts, photo.realOffset])
                    self.photosRealm.append(photoRealm)
                }
                self.useRealmData.savePhotosData(ownerId: ownerId, photos: self.photosRealm)
                print(ownerId)
                self.useRealmData.getPhotosData(ownerId: ownerId)
                completion(self.photosRealm)
            }catch{
                print(error)
            }
        }
    }
    func loadUserData() {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/users.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else{return}
            let user = try? JSONDecoder().decode(UserModel.self, from: data).response
            for i in user ?? [] {
                let userRealm = UserRealm(value:[i.id,i.firstName,i.lastName,i.isClosed,i.canAccessClosed,i.photo50])
                self.usersRealm.append(userRealm)
            }
            self.useRealmData.saveUserData(user: self.usersRealm)
            print(response.value ?? "no users")
        }
 
    }
    
}
