//
//  VKService.swift
//  VKClient
//
//  Created by Alex Larin on 14.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import Alamofire
enum RequestError:Error{
    case failedRequest(massage:String)
    case decodableError
}
class VKService {
    let saveRealmData = SaveRealmData()
    typealias Out = Swift.Result
    
    func loadData<T:Decodable>(request:URLRequest,completion: @escaping(Out<[T], Error>) ->Void){
           SessionManager.custom.request(request).responseData{
                 response in
                 switch response.result {
                   case .failure(let error):
                      completion(.failure(RequestError.failedRequest(massage: error.localizedDescription)))
                   case .success(let data):
                      do {
                        let result = try JSONDecoder().decode(CommonResponse<T>.self, from: data)
                        print(result)
                        completion(.success(result.response.items))
                      } catch {
                        completion(.failure(error))
                      }
                }
            }
    }
    func loadFriendsData(completion: @escaping (Out<[ItemsFriend], Error>) ->Void){
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
        loadData(request: request){ completion($0)}
        
    }
    func loadGroupsData(completion: @escaping (Out<[ItemsGroup], Error>) ->Void){
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
        loadData(request: request){completion($0)}
        /*
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else{return}
            let groups = try? JSONDecoder().decode(GroupModel.self, from: data).response?.items
            self.saveRealmData.saveGroupData(groups: groups ?? [])
            print(groups ?? "no groups")
            completion(groups ?? [])
        }
 */
    }
    func loadPhotosData(ownerId:Int,completion: @escaping (Out<[ItemsPhotos], Error>) -> Void){
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
        loadData(request: request){completion($0)}
        /*
        SessionManager.custom.request(request).responseData{
            response in
            guard let data = response.value else{return}
            let photos = try? JSONDecoder().decode(PhotosModel.self, from: data).response?.items
            self.saveRealmData.savePhotosData(photos: photos ?? [])
            print(photos ?? "no photos")
            completion(photos ?? [])
        }
 */
    }
    func loadUserData(completion: @escaping ([ResponseUser]) ->Void) {
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
            self.saveRealmData.saveUserData(user: user ?? [])
            print(response.value ?? "no users")
            completion(user ?? [])
        }
 
    }
    
}
