//
//  NetworkError.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case invalidURL
    case responseError
    
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "API url is invalid"
        case .responseError:
            "Response error"
        case .unknownError:
            "Unknown error"
        }
    }
}
