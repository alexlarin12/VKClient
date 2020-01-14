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
    let userId = String(Session.instance.userId)
    let accessToken = Session.instance.token
    
    func loadFriendsData(){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseJSON{
            response in
            print(response.value ?? "no friends")
        }
    }
    func loadGroupsData(){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "site"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseJSON{
            response in
            print(response.value ?? "no groups")
        }
    }
    func loadPhotosData(){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "-\(userId)"),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseJSON{
            response in
            print(response.value ?? "no photos")
        }
    }
    
}
