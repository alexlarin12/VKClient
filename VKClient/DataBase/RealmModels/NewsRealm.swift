//
//  NewsRealm.swift
//  VKClient
//
//  Created by Alex Larin on 24.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealm: Object {
   //news
     var attachments = List<NewsAttachmentRealm>()
    @objc dynamic var type: String = ""
    @objc dynamic var sourceID: Int = 0
    @objc dynamic var date: Double = 0
    @objc dynamic var postType: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var markedAsAds: Int = 0
    @objc dynamic var comments: NewsCommentsRealm?
    @objc dynamic var likes: LikeRealm?
    @objc dynamic var reposts: NewsRepostsRealm?
    @objc dynamic var views: NewsViewsRealm?
    @objc dynamic var isFavorite: Bool = true
    @objc dynamic var postID: Int = 0
}
class NewsAttachmentRealm: Object {
    @objc dynamic var type = ""
    @objc dynamic var photo:PhotosRealm?
}
class NewsCommentsRealm: Object {
    @objc dynamic var count = 0
}

class NewsViewsRealm: Object {
    @objc dynamic var count = 0
}

class NewsRepostsRealm: Object {
    @objc dynamic var count = 0
}







/*
   //attachments
   @objc dynamic var typeAtt: String = ""
   @objc dynamic var idPhotoAtt: Int = 0
   @objc dynamic var albumIDPhotoAtt: Int = 0
   @objc dynamic var ownerIDPhotoAtt: Int = 0
   @objc dynamic var userIDPhotoAtt: Int = 0
    //size
   @objc dynamic var typeSize: String = ""
   @objc dynamic var url: String = ""
   @objc dynamic var width: Int = 0
   @objc dynamic var height: Int = 0
    //attachments
   @objc dynamic var textPhotoAtt: String = ""
   @objc dynamic var datePhotoAtt: Int = 0
   @objc dynamic var accessKeyPhotoAtt: String = ""
    //comments
   @objc dynamic var countComments: Int = 0
   @objc dynamic var canPost: Int = 0
   @objc dynamic var groupsCanPost: Bool = true
    //likes
   @objc dynamic var countLikes: Int = 0
   @objc dynamic var userLikes: Int = 0
   @objc dynamic var canLike: Int = 0
   @objc dynamic var canPublish: Int = 0
    //reposts
   @objc dynamic var countReposts: Int = 0
   @objc dynamic var userReposted: Int = 0
    //views
   @objc dynamic var countViews: Int = 0
    //news
  
    
  //  override class func primaryKey() -> String? {
    //    return "postID"
  //  }
    
*/

