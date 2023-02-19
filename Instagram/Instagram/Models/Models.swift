//
//  Models.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/16/21.
//

import Foundation

public enum Gender {
    case male, female, other
}

public struct User {
    let userName: String
    let bio: String
    let name: (first: String, last: String)
    let birthdate: Date
    let gender: Gender
    let count: UserCount
    let joinDate: Date
}

public struct UserCount {
    let followes: Int
    let following: Int
    let posts: Int
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let postURL: URL
    let userName: String
    let caption: String?
    let thumbnailImage: URL
    let likes: [PostLike]
    let comments: [PostComment]
    let createdOn: Date
    let taggedUsers: [String]
}

public struct PostLike {
    let userName: String
    let postIdentifier: String
}

public struct CommentLike {
    let userName: String
    let commentIdenifier: String
}

public struct PostComment {
    let identifier: String
    let userName: String
    let text: String
    let createdOn: Date
    let likes: [CommentLike]
}


