//
//  APIClient.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Combine
import Foundation

struct APIClient {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: Endpoint) throws -> AnyPublisher<T, NetworkingError> {
        session.dataTaskPublisher(for: try endpoint.buildRequest())
            .tryMap { data, response in
                print("Response code: \((response as? HTTPURLResponse)?.statusCode)")
                
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw NetworkingError.responseError
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkingError in
                print(error)
                if let networkingError = error as? NetworkingError {
                    return networkingError
                } else {
                    print("shit")
                    return NetworkingError.responseError
                }
            }
            .eraseToAnyPublisher()
    }
}

