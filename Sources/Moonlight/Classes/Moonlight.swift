//
//  File.swift
//
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation
import Combine

import Combine
import Foundation

public class Moonlight: MoonlightContract {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    #if DEBUG
    private func debugLog(_ message: String) { print("DEBUG: \(message)") }
    #else
    private func debugLog(_ message: String) {}
    #endif
    
    public init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    public func requestWithAsyncAwait<T: Decodable>(
        for url: String, decodeType: T.Type? = nil, requestType: HTTPMethod? = .get,
        queryParameters: [QueryParameter]? = nil, headers: [Header]? = nil, bodies: [Body]? = nil
    ) async throws -> T {
        
        guard let requestType = requestType else { throw NetworkError.invalidURL }
        
        guard
            let request = buildRequest(
                url: url, requestType: requestType.rawValue, queryParameters: queryParameters,
                headers: headers, bodies: bodies)
        else {
            #if DEBUG
            self.debugLog("\(NetworkError.invalidURL)")
            #endif
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(for: request)
        #if DEBUG
        self.debugLog("\(response)")
        #endif
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
        
    }
    
    public func requestWithCombine<T: Decodable>(
        for url: String, decodeType: T.Type? = nil, requestType: HTTPMethod? = .get,
        queryParameters: [QueryParameter]? = nil, headers: [Header]? = nil, bodies: [Body]? = nil
    ) -> AnyPublisher<T, Error> {
        
        guard let requestType = requestType else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        guard
            let request = buildRequest(
                url: url, requestType: requestType.rawValue, queryParameters: queryParameters,
                headers: headers, bodies: bodies)
        else { return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher() }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                #if DEBUG
                self.debugLog("\(response)")
                #endif
                let decoded = try self.decoder.decode(T.self, from: data)
                return decoded
            }
            .mapError { error in
                #if DEBUG
                self.debugLog("\(NetworkError.requestFailed(error))")
                #endif
                return NetworkError.requestFailed(error)
            }
            .eraseToAnyPublisher()
    }
    
    private func buildRequest(
        url: String, requestType: String, queryParameters: [QueryParameter]?, headers: [Header]?,
        bodies: [Body]?
    ) -> URLRequest? {
        
        guard let url = URL(string: url) else { return nil }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = addQueryParameters(queryParameters: queryParameters)
        
        var request = URLRequest(url: urlComponents?.url ?? url)
        request.httpMethod = requestType
        
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.type) }
        
        bodies.map { bodyArray in
            guard let body = bodyArray.first else { return }
            request.addValue(body.contentType, forHTTPHeaderField: "Content-Type")
            request.httpBody = body.content
        }
        
        #if DEBUG
        self.debugLog("\(request)")
        #endif
        return request
        
    }
    
    private func addQueryParameters(queryParameters: [QueryParameter]?) -> [URLQueryItem]? {
        
        if let queryParameters = queryParameters {
            return queryParameters.map { URLQueryItem(name: $0.name, value: $0.value) }
        }
        return nil
        
    }
    
}
