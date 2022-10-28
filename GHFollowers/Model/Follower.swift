//
//  Follower.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 05.10.2022.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
}
