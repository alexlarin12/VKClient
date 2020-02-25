//
//  NewsModel.swift
//  VKClient
//
//  Created by Alex Larin on 24.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
// MARK: - News
struct News: Decodable {
    let type: String
    let sourceID, date: Int
    let postType, text: String
    let markedAsAds: Int
    let attachments: [Attachment]?
    let postSource: PostSource
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let views: Views
    let isFavorite: Bool
    let postID: Int

    enum CodingKeys: String, CodingKey {
        case type
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case postID = "post_id"
    }
}

// MARK: - Attachment
struct Attachment: Decodable {
    let type: AttachmentType
    let photo: AttPhoto?
    let video: Video?
}

// MARK: - Photo
struct AttPhoto: Decodable {
    let id, albumID, ownerID, userID: Int
    let sizes: [AttSize]
    let text: String
    let date: Int
    let accessKey: String

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case userID = "user_id"
        case sizes, text, date
        case accessKey = "access_key"
    }
}

// MARK: - Size
struct AttSize: Decodable {
    let type: SizeType?
    let url: String
    let width, height: Int
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case type
        case url, width, height
        case withPadding = "with_padding"
    }
}

enum SizeType: String, Decodable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case x = "x"
    case y = "y"
    case z = "z"
    case w = "w"
}

enum AttachmentType: String, Decodable {
    case photo = "photo"
    case video = "video"
}

// MARK: - Video
struct Video: Decodable {
    let accessKey: String
    let canComment, canLike, canRepost, canSubscribe: Int
    let canAddToFaves, canAdd, comments, date: Int
    let videoDescription: String
    let duration: Int
    let image: [Size]
    let id, ownerID: Int
    let title: String
    let isFavorite: Int
    let trackCode: String
    let type: String
    let views, localViews: Int
    let platform: String

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type
        case views
        case localViews = "local_views"
        case platform
    }
}

// MARK: - Comments
struct Comments: Decodable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Likes
struct Likes: Decodable {
    let count, userLikes, canLike, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct PostSource: Decodable {
    let type: String
}

// MARK: - Reposts
struct Reposts: Decodable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Decodable {
    let count: Int
}

// MARK: - Profile
struct Profile: Decodable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool
    let sex: Int
    let screenName: String
    let photo50, photo100: String
    let online, onlineMobile: Int
    let onlineInfo: OnlineInfo

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
        case onlineMobile = "online_mobile"
        case onlineInfo = "online_info"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Decodable {
    let visible, isOnline, isMobile: Bool

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
