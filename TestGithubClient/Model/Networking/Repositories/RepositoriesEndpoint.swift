//
//  RepositoriesEndpoint.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Foundation

enum RepositoriesEndpoint: Endpoint {
    case searchRepositories(query: String, page: Int)
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .searchRepositories:
            return "/search/repositories"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .searchRepositories:
            return .get
        }
    }
    
    var queryParameters: [String: String] {
        switch self {
        case let .searchRepositories(query, page):
            return ["q": query,
                    "page": "\(page)"]
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.github+json",
                "Authorization": "Bearer YOUR_TOKEN", // TODO: Move token to build settings
                "X-GitHub-Api-Version" : "2022-11-28"
        ]
    }
}
