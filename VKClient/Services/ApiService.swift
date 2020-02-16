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
    let useRealmData = FriendsRepositiry()
    var usersRealm = [UserRealm]()
    typealias Out = Swift.Result
    private let idFromKeychain = KeychainWrapper.standard.integer(forKey: "id")!
    private let tokenFromKeychain = KeychainWrapper.standard.string(forKey: "token")
    
    func loadData<T:Decodable>(request:URLRequest,completion: @escaping(Out<[T], Error>) ->Void){
       SessionManager.custom.request(request).responseData{
            response in
            switch response.result {
              case .failure(let error):
                completion(.failure(RequestError.failedRequest(massage: error.localizedDescription)))
              case .success(let data):
                do {
                  let result = try JSONDecoder().decode(CommonResponse<T>.self, from: data)
                  completion(.success(result.response.items))
                } catch {
                  completion(.failure(error))
                }
            }
        }
    }
    
    func loadFriendsData(token:String, userId:Int, completion: @escaping (Out<[ItemsFriend], Error>) -> Void){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(userId)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        loadData(request: request){ completion($0)}
    }
    
    func loadGroupsData(token:String, userId:Int, completion: @escaping (Out<[ItemsGroup], Error>) -> Void){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value:String(userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "site"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        loadData(request: request){ completion($0)}
    }
    
    func loadPhotosData(token:String, ownerId:Int, completion: @escaping (Out<[ItemsPhotos], Error>) -> Void){
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(ownerId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        loadData(request: request){ completion($0)}
    }
        
    func loadUserData(token:String, userId:Int, completion: @escaping ([ResponseUser]) -> Void) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/users.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(userId)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else{return}
            do{
                let user = try JSONDecoder().decode(UserModel.self, from: data).response
        //      self.useRealmData.saveUserData(user: self.usersRealm)
                completion(user ?? [])
            }catch{
                print(error)
            }
        }
    }
    
}