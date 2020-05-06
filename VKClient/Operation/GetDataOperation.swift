//
//  GetDataOperation.swift
//  VKClient
//
//  Created by Alex Larin on 27.04.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import Alamofire

class DownloadOperation: AsyncOperation{
    var apiService = ApiService()
    
    let token: String
    let userId: Int
    var user: [ResponseUser]?
    override func main() {
        apiService.loadUserData(token: token, userId: userId) {[weak self] user in
            self?.user = user
            self?.state = .finished
        }
    }
    init(token: String, userId: Int) {
        self.token = token
        self.userId = userId
    }
}

class SaveToRealmDataOperation: AsyncOperation{
    let database = UserRepository()
    
    override func main() {
        guard let downloadOperation = dependencies.first as? DownloadOperation,
            let user = downloadOperation.user else {return}
        
        self.database.saveUserData(user: user)
        self.state = .finished
    }
   
}

class DisplayDataOperation:AsyncOperation{
    let database = UserRepository()
    var mainNameLabel: String?
    var mainIdLabel: String?
    var avatar: String?
    
        override func main() {
            let userRealm = self.database.getUserData()
            userRealm.forEach { user in
                self.mainNameLabel = user.firstName
                self.mainIdLabel = user.lastName
                self.avatar = user.photo50
                }
            self.state = .finished
      }
    
}
