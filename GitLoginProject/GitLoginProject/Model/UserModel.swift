//
//  UserModel.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 28.01.26.
//

import Foundation

struct UserModel: Codable {

    let id: Int
    let login: String
    let name: String?
    let avatarURL: String?
    let profileURL: String

    let publicRepos: Int

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case avatarURL = "avatar_url"
        case profileURL = "html_url"
        case publicRepos = "public_repos"
    }
}
