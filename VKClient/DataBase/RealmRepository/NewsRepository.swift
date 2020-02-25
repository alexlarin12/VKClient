//
//  NewsRepository.swift
//  VKClient
//
//  Created by Alex Larin on 24.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRepository {
      var newsRealm = [NewsRealm]()
        
      func saveNewsData(news: [News]){
             do {
                let realm = try Realm()
                realm.beginWrite()
                var groupsToAdd = [NewsRealm]()
                news.forEach { oneNew in
                    let newsRealm = NewsRealm()
                    newsRealm.type = oneNew.type
                    newsRealm.sourceID = oneNew.sourceID
                    newsRealm.date = oneNew.date
                    newsRealm.postType = oneNew.postType
                    newsRealm.text = oneNew.text
                    newsRealm.markedAsAds = oneNew.markedAsAds
                    /*
                    newsRealm.typeAtt = oneNew.typeAtt
                    newsRealm.idPhotoAtt = oneNew.idPhotoAtt
                    newsRealm.albumIDPhotoAtt = oneNew.albumIDPhotoAtt
                    newsRealm.ownerIDPhotoAtt = oneNew.ownerIDPhotoAtt
                    newsRealm.typeSize = oneNew.typeSize
                    newsRealm.url = oneNew.url
                    newsRealm.width = oneNew.width
                    newsRealm.height = oneNew.height
                    newsRealm.textPhotoAtt = oneNew.textPhotoAtt
                    newsRealm.datePhotoAtt = oneNew.datePhotoAtt
                    newsRealm.accessKeyPhotoAtt = oneNew.accessKeyPhotoAtt
                    newsRealm.countComments = oneNew.countComments
                    newsRealm.canPost = oneNew.canPost
                    newsRealm.groupsCanPost = oneNew.groupsCanPost
                    newsRealm.countLikes = oneNew.countLikes
                    newsRealm.userLikes = oneNew.userLikes
                    newsRealm.canLike = oneNew.canLike
                    newsRealm.canPublish = oneNew.canPublish
                    newsRealm.countReposts = oneNew.countReposts
                    newsRealm.userReposted = oneNew.userReposted
                    newsRealm.countViews = oneNew.countViews
 */
                    newsRealm.isFavorite = oneNew.isFavorite
                    newsRealm.postID = oneNew.postID
                    groupsToAdd.append(newsRealm)
                    
                }
                realm.add(groupsToAdd)
                try realm.commitWrite()
             } catch  {
                 print(error)
             }
         }
         func getNewsData() throws -> Results<NewsRealm> {
             do {
                let realm = try Realm()
                return realm.objects(NewsRealm.self)
             } catch {
                 throw error
             }
         }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

