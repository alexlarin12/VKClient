//
//  NewsModel2.swift
//  VKClient
//
//  Created by Alex Larin on 24.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
struct NewsModel2: Decodable {
    let response: ItemNews
}
struct ItemNews: Decodable {
    let items: [Item]
    let profiles: [Profile]
    let groups: [Group]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}
//GROUP
struct Group: Decodable {
    let id: Int
    let name:String
    let screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
//PROFILE
struct Profile: Decodable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool?
    let sex: Int
    let screenName: String?
    let photo50, photo100: String
    let online: Int
    let onlineInfo: Online
    let deactivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
        case onlineInfo = "online_info"
        case deactivated
    }
}
struct Online: Decodable {
    let visible: Bool
    let lastSeen, appID: Int?
    let isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case appID = "app_id"
        case isMobile = "is_mobile"
    }
}
//ITEM
struct Item: Decodable {
  let canDoubtCategory: Bool?
  let canSetCategory: Bool?
  let type: String
  let sourceID, date: Int
  let postType, text: String?
  let markedAsAds: Int?
 // let attachments: [Attachments2]?
    let typeAttachments: String
  //  let photo: [Photos2]?
    var idPhoto: Int = 0
  //  let albumIDPhoto: Int
   // let ownerIDPhoto: Int
  //  let userIDPhoto: Int
    //  let sizes: [Size2]
    var url: String = ""
    var typeSize: String = ""
    var textPhoto: String = ""
    var datePhoto: Int = 0
 //   let accessKeyPhoto: String
    
    
 // let postSource: PostSource2?
 // let comments: Comments2?
    let countComments: Int
    let canPostComments: Int
 // let likes: Likes2?
    let countLikes: Int
    let userLikes: Int
    let canLike: Int
    let canPublishLikes: Int
 // let reposts: Reposts2?
    let countReposts: Int
    let userReposted: Int
//  let views: Views2?
    let countViews: Int
  let isFavorite: Bool?
  let postID: Int

  enum CodingKeys: String, CodingKey {
      case canDoubtCategory = "can_doubt_category"
      case canSetCategory = "can_set_category"
      case type
      case sourceID = "source_id"
      case date
      case postType = "post_type"
      case text
      case markedAsAds = "marked_as_ads"
      case attachments
      case comments, likes, reposts, views
      case isFavorite = "is_favorite"
      case postID = "post_id"
  }
    init(from decoder:Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     self.canDoubtCategory = try? container.decode(Bool.self, forKey: .canDoubtCategory)
     self.canSetCategory = try? container.decode(Bool.self, forKey: .canSetCategory)
     self.type = try container.decode(String.self, forKey: .type)
     self.sourceID = try container.decode(Int.self, forKey: .sourceID)
     self.date = try container.decode(Int.self, forKey: .date)
     self.postType = try container.decode(String.self, forKey: .postType)
     self.text = try container.decode(String.self, forKey: .text)
     self.markedAsAds = try container.decode(Int.self, forKey: .markedAsAds)
     self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
     self.postID = try container.decode(Int.self, forKey: .postID)
        var attachmentsContainer = try container.nestedUnkeyedContainer(forKey: .attachments)
        let attachmentsTypeContainer = try attachmentsContainer.nestedContainer(keyedBy: Attachments2.CodingKeys.self)
        self.typeAttachments = try attachmentsTypeContainer.decode(String.self, forKey: .typeAttachments)
        switch typeAttachments {
        case "photo":
            let attachmentsPhotoContainer = try attachmentsContainer.nestedContainer(keyedBy: PhotoAttachments2.CoddingKeys.self)
          //  self.photo = try attachmentsPhotoContainer.decode([Photos2].self, forKey: .photo)
            
            let photoContainer = try attachmentsPhotoContainer.nestedContainer(keyedBy: PhotoAttachments2.CoddingKeys.self, forKey: .photo)
            let photoContainer2 = try photoContainer.nestedContainer(keyedBy: Photos2.CodingKeys.self, forKey: .photo)
            self.idPhoto = try photoContainer2.decode(Int.self, forKey: .idPhoto)
            self.textPhoto = try photoContainer2.decode(String.self, forKey: .textPhoto)
            self.datePhoto = try photoContainer2.decode(Int.self, forKey: .datePhoto)
            var sizeContainer = try photoContainer2.nestedUnkeyedContainer(forKey: .sizes)
            let sizeContainer2 = try sizeContainer.nestedContainer(keyedBy: Size2.CodingKeys.self)
            self.url = try sizeContainer2.decode(String.self, forKey: .url)
            self.typeSize = try sizeContainer2.decode(String.self, forKey: .typeSize)
            
        default:
            break
        }
        let commentsContainer = try container.nestedContainer(keyedBy: Comments2.CodingKeys.self, forKey: .comments)
        self.countComments = try commentsContainer.decode(Int.self, forKey: .countComments)
        self.canPostComments = try commentsContainer.decode(Int.self, forKey: .canPostComments)
        
        let likesContainer = try container.nestedContainer(keyedBy: Likes2.CodingKeys.self, forKey: .likes)
        self.countLikes = try likesContainer.decode(Int.self, forKey: .countLikes)
        self.canLike = try likesContainer.decode(Int.self, forKey: .canLike)
        self.canPublishLikes = try likesContainer.decode(Int.self, forKey: .canPublishLikes)
        self.userLikes = try likesContainer.decode(Int.self, forKey: .userLikes)

        let repostsContainer = try container.nestedContainer(keyedBy: Reposts2.CodingKeys.self, forKey: .reposts)
        self.countReposts = try repostsContainer.decode(Int.self, forKey: .countReposts)
        self.userReposted = try repostsContainer.decode(Int.self, forKey: .userReposted)
        
        let viewsContainer = try container.nestedContainer(keyedBy: Views2.CodingKeys.self, forKey: .views)
        self .countViews = try viewsContainer.decode(Int.self, forKey: .countViews)
    
    }

//ATTACHMENTS
struct Attachments2: Decodable {
    let typeAttachments: String
    enum CodingKeys: String, CodingKey {
        case typeAttachments = "type"
    }
}
//PHOTO
struct PhotoAttachments2: Decodable {
    var photo: Photos2
    enum CoddingKeys: String, CodingKey {
        case photo
    }
}
struct Photos2: Decodable {
    let idPhoto, albumIDPhoto, ownerIDPhoto, userIDPhoto: Int
    let sizes: [Size2]
    let textPhoto: String
    let datePhoto: Int
    let accessKeyPhoto: String

    enum CodingKeys: String, CodingKey {
        case idPhoto
        case albumIDPhoto = "album_id"
        case ownerIDPhoto = "owner_id"
        case userIDPhoto = "user_id"
        case sizes
        case textPhoto = "text"
        case datePhoto = "data"
        case accessKeyPhoto = "access_key"
    }
}
struct Size2: Decodable {
    let typeSize: TypeEnum2
    let url: String
    let width, height: Int
    enum CodingKeys: String, CodingKey {
        case typeSize = "type"
        case url
        case width
        case height
    }
}
enum TypeEnum2: String, Decodable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
//LINK
struct LinkAttachments2: Decodable {
    var link: Link2
}

struct Link2: Decodable {
    var photo: [Photos2]

    enum CodingKeys: String, CodingKey {
        case photo
    }
}
// ВИДЕО
struct VideoAttachments2: Decodable {
    var video: Video2
}
struct Video2: Decodable {
    let image: [ImageVideo2]
    enum CodingKeys: String, CodingKey {
        case image
    }
}

struct ImageVideo2: Decodable {
    let height: Int
    let url: String
    let width, withPadding: Int
    enum CodingKeys: String, CodingKey {
        case height
        case url
        case width
        case withPadding = "with_padding"
    }
}
//COMMENTS
struct Comments2: Decodable {
    var countComments, canPostComments: Int

    enum CodingKeys: String, CodingKey {
        case countComments = "count"
        case canPostComments = "can_post"
    }
}
//LIKES
struct Likes2: Decodable {
    var countLikes, userLikes, canLike, canPublishLikes: Int

    enum CodingKeys: String, CodingKey {
        case countLikes = "count"
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublishLikes = "can_publish"
    }
}
//REPOSTS
struct Reposts2: Decodable {
    let countReposts, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case countReposts = "count"
        case userReposted = "user_reposted"
    }
}
//VIEWS
struct Views2: Decodable {
    let countViews: Int
    enum CodingKeys: String, CodingKey {
        case countViews = "count"
    }
}

}
