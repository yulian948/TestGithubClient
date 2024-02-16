//
//  RepositoriesResponse.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Foundation

struct RepositoriesResponse: Codable {
    let items: [Repository]
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case totalCount = "total_count"
    }
}
