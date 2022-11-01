//
//  User.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 04.10.2022.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    var following: Int?
    var followers: Int?
    let createdAt: String
}
