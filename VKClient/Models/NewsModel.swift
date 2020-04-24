//
//  NewsModel2.swift
//  VKClient
//
//  Created by Alex Larin on 27.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import Kingfisher

struct NewsModel: Decodable {
    let response: ItemsNews
}
struct ItemsNews: Decodable {
    let items: [ResponseItem]
    let profiles: [Profiles]
    let groups: [Groups]
    let nextFrom: String
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}
struct ResponseItem: Decodable {
    let canDoubtCategory: Bool?
    let canSetCategory: Bool?
    let type: String
    let sourceID, date: Int
    let postType, text: String?
    var copyHistory: [CopyHistory]? = []
    let markedAsAds: Int?
    var photos: [Photos]?
    var links: [Link]?
    var videos: [Video]?
    let postSource: PostSource?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
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
        case copyHistory = "copy_history"
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case postID = "post_id"
    }
     enum AttachmentsKeys: String, CodingKey {
           case type
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
        self.postSource = try? container.decode(PostSource.self, forKey: .postSource)
        self.comments = try? container.decode(Comments.self, forKey: .comments)
        self.likes = try? container.decode(Likes.self, forKey: .likes)
        self.reposts = try? container.decode(Reposts.self, forKey: .reposts)
        self.views = try? container.decode(Views.self, forKey: .views)
   //     var copyHistoryArray = try container.nestedUnkeyedContainer(forKey: .copyHistory)
    //    let firstHistoryArray = try copyHistoryArray.nestedContainer(keyedBy: CopyHistory.CodingKeys.self)
        self.copyHistory = try? container.decode([CopyHistory].self, forKey: .copyHistory)
       // print("copyHistory = \(self.copyHistory ?? []) Репост")
        if self.copyHistory != nil{
            if var copyHistoryAttachmentArray = try? container.nestedUnkeyedContainer(forKey: .copyHistory){
            while !copyHistoryAttachmentArray.isAtEnd {
                let singleAttachmentContainer = try copyHistoryAttachmentArray.nestedContainer(keyedBy: CopyHistory.CodingKeys.self)
                 //   let textCopeHistory = try singleAttachmentContainer.decode(String.self, forKey: .text)
                 //   print("появился массив copyHistory. Содержит:\(textCopeHistory)TEKCT")
                var singleAttachmentsContainer = try singleAttachmentContainer.nestedUnkeyedContainer(forKey: .attachments)
                let attachmentContainer = try singleAttachmentsContainer.nestedContainer(keyedBy: AttachmentsKeys.self)
                let attachmentType = try attachmentContainer.decode(String.self, forKey: .type)
                print("type\(attachmentType)")
                switch attachmentType {
                case "photo":
                    let attachment = try? singleAttachmentContainer.decode([NewsPhotoAttachments].self,forKey: .attachments)
                    self.photos = attachment?.compactMap { $0.photo } ?? []
                    //print(photos ?? [])
                case "link":
                    let attachmentLink = try? singleAttachmentContainer.decode([NewsLinkAttachments].self, forKey: .attachments)
                    self.links = attachmentLink?.compactMap { $0.link} ?? []
                   //print(links ?? [])
                case "video":
                    let attachmentVideo = try? singleAttachmentContainer.decode([NewsVideoAttachments].self, forKey: .attachments)
                    self.videos = attachmentVideo?.compactMap { $0.video } ?? []
                    //print(videos ?? [])
                default: print("defaultAttachmentType in CopyHistory")
                }
                
                
                }
                    
            }
        }
       /*
        if let attachment = try? container.decode([NewsLinkAttachments?].self, forKey: .attachments){
            self.links = attachment.compactMap { $0?.link }
            print("link\(attachment)")
        }else{
            self.links = []
        }
         if let attachment = try? container.decode([NewsVideoAttachments?].self, forKey: .attachments){
                       self.videos = attachment.compactMap {$0?.video}
                   print(attachment)
                   }else{
                       self.videos = []
                   }
        if let attachment = try? container.decode([NewsPhotoAttachments?].self, forKey: .attachments){
            self.photos = attachment.compactMap { $0?.photo }
        }else{
            self.photos = []
        }*/
        if var newsAttachmentsArray = try? container.nestedUnkeyedContainer(forKey: .attachments){
            while !newsAttachmentsArray.isAtEnd {
                let singleAttachmentContainer = try newsAttachmentsArray.nestedContainer(keyedBy: AttachmentsKeys.self)
                let attachmentType = try singleAttachmentContainer.decode(String.self, forKey: .type)
                print(attachmentType)
                switch attachmentType {
                case "photo":
                    let attachment = try? container.decode([NewsPhotoAttachments].self,forKey: .attachments)
                    self.photos = attachment?.compactMap { $0.photo } ?? []
                   // print(photos ?? [])
                case "link":
                    let attachmentLink = try? container.decode([NewsLinkAttachments].self, forKey: .attachments)
                    self.links = attachmentLink?.compactMap { $0.link} ?? []
                  // print(links ?? [])
                case "video":
                    let attachmentVideo = try? container.decode([NewsVideoAttachments].self, forKey: .attachments)
                    self.videos = attachmentVideo?.compactMap { $0.video } ?? []
                   // print(videos ?? [])
                default: print("defaultAttachmentType")
                }
            }
        }
    }
}
struct NewsPhotoAttachments: Decodable {
    var photo: Photos
}
struct Photos: Decodable {
    let id, albumID, ownerID, userID: Int
    let sizes: [Size]
    let text: String
    let date: Int
    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case userID = "user_id"
        case sizes, text, date
    }
}
struct Size: Decodable {
    let type: TypeEnum
    let url: String
    let width, height: Int
}
enum TypeEnum: String, Decodable {
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
    case e = "e"
    case k = "k"
    case l = "l"
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
// LINK
struct NewsLinkAttachments: Decodable {
    var link: Link?
}
struct Link: Decodable {
    var url: String?
    var title: String
    var photo: LinkPhoto?
    var button: LinkButton?
    enum CodingKeys: String, CodingKey {
        case title
        case photo = "photo"
        case button
        case url
    }
}
struct LinkPhoto: Decodable {
    let sizes: [LinkSize]

    enum CodingKeys: String, CodingKey {
        case sizes = "sizes"
    }
}
struct LinkSize: Decodable {
    let type: TypeEnum
    let url: String
    let width: Int
    let height: Int
}
struct LinkButton: Decodable {
    let title: String
    enum CodingKeys: String, CodingKey {
        case title
    }
}
// ВИДЕО
struct NewsVideoAttachments: Decodable {
    var video: Video
}
struct Video: Decodable {
  /*  let accessKey: String
    let canComment, canLike, canReposts, canSubscribe, canAddToFaves, canAdd, comments, date: Int
    let description: String
    let duration: Int */
    var firstFrame: [FirstFrameVideo]?
    var image: [ImageVideo]?
    enum CodingKeys: String, CodingKey {
      /*  case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canReposts = "can_reposts"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments
        case date
        case description
        case duration */
        case image
        case firstFrame = "first_frame"
    }
}
struct ImageVideo: Decodable {
    let height: height
    let url: String
    let width: Int
}
enum height: Int, Decodable {
    case h96 = 96
    case h120 = 120
    case h240 = 240
    case h450 = 450
    case h720 = 720
    case h180 = 180
    case h405 = 405
    case h576 = 576
    case h2304 = 2304
    case h320 = 320
    case h1024 = 1024
    case h4096 = 4096
    
}
struct FirstFrameVideo: Decodable {
    let height: Int
    let url: String
    let width: Int
}
struct PostSource: Decodable {
    let type: String
}
struct Comments: Decodable {
    var count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}
struct Likes: Decodable {
    var count, userLikes, canLike, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}
struct Reposts: Decodable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}
struct Views: Decodable {
    let count: Int
}
struct Profiles: Decodable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool?
    let sex: Int
    let screenName: String?
    let photo50, photo100: String
    let online: Int
    let onlineInfo: OnlineInfo
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
struct OnlineInfo: Decodable {
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
struct Groups: Decodable {
    let id: Int
    let name:String
    let screenName: String
    let isClosed: Int
    let type: String
    let isAdmin: Int?
    let isMember: Int?
    let isAdvertiser: Int?
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
/// CopyHistoryAttachment
struct CopyHistoryAttachment: Decodable {
    let photo: Photos?
    let link: Link?
    let video: Video?
}
struct CopyHistory: Decodable {
    let id, ownerID, fromID, date: Int
    let text: String
    let attachments: [CopyHistoryAttachment]?
      
    enum CodingKeys: String, CodingKey {
        case id, date, text
        case attachments
        case ownerID = "owner_id"
        case fromID = "from_id"
    }
}
