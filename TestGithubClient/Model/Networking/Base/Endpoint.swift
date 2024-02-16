//
//  Endpoint.swift
//  TestGithubClient
//
//  Created by Yulian on 05.02.2024.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryParameters: [String: String] { get }
    var headers: [String : String]? { get }
}

extension Endpoint {
    func buildRequest() throws -> URLRequest {
        guard var components = URLComponents(url: self.baseURL, resolvingAgainstBaseURL: true) else {
            throw NetworkingError.invalidURL
        }
        
        components.path = path
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.headers
        
        return request
    }
}
