//
//  Repository.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String?
    let owner: Owner?
    let htmlURL: URL
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case owner
        case htmlURL = "html_url"
        case stargazersCount = "stargazers_count"
    }
}

struct Owner: Codable {
    let name, email, login: String?
    let id: Int
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name, email, login, id
        case avatarURL = "avatar_url"
    }
}
