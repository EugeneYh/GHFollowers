//
//  User.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 04.10.2022.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: String?
    var followers: String?
    var createdAt: String
}
