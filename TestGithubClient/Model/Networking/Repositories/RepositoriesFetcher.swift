//
//  RepositoriesFetcher.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Combine
import Foundation

protocol RepositoriesFetcherProtocol {
    func fetchRepositories(query: String, page: Int) -> AnyPublisher<RepositoriesResponse, NetworkingError>
}

struct RepositoriesFetcher: RepositoriesFetcherProtocol {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchRepositories(query: String, page: Int) -> AnyPublisher<(RepositoriesResponse), NetworkingError> {
        do {
            return try apiClient.request(endpoint: RepositoriesEndpoint.searchRepositories(query: query, page: page))
        } catch {
            return Fail(error: error as? NetworkingError ?? NetworkingError.unknownError)
                .eraseToAnyPublisher()
        }
    }
}
