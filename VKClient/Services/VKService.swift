//
//  VKService.swift
//  VKClient
//
//  Created by Alex Larin on 14.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import Alamofire
class VKService {
    
    func loadFriendsData(completion: @escaping ([ItemsFriend]) ->Void){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else {return}
            let friends = try? JSONDecoder().decode(FriendModel.self, from: data).response?.items
            print(friends ?? "no friends")
            completion(friends ?? [])
        }
    }
    func loadGroupsData(completion: @escaping ([ItemsGroup]) ->Void){
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
            let groups = try? JSONDecoder().decode(GroupModel.self, from: data).response?.items
            print(groups ?? "no groups")
            completion(groups ?? [])
        }
    }
    func loadPhotosData(ownerId:Int,completion: @escaping ([ItemsPhotos]) -> Void){
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
            let photos = try? JSONDecoder().decode(PhotosModel.self, from: data).response?.items
            print(photos ?? "no photos")
            completion(photos ?? [])
        }
    }
    func loadUserData(completion: @escaping ([ResponseUser])->Void){
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
            let user = try! JSONDecoder().decode(UserModel.self, from: data).response
            print(response.value ?? "no users")
            completion(user ?? [])
        }
    }
    
}
