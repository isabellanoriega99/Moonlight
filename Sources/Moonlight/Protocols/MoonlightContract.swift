//
//  File.swift
//  
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation
import Combine

public protocol MoonlightContract {
    
    func requestWithAsyncAwait<T: Decodable>(
        for url: String, responseType: T.Type?, requestType: HTTPMethod?,
        queryParameters: [QueryParameter]?, headers: [Header]?, bodies: [Body]?
    ) async throws -> (data: Data, response: URLResponse, decoded: T)
    
    func requestWithCombine<T: Decodable>(
        for url: String, responseType: T.Type?, requestType: HTTPMethod?,
        queryParameters: [QueryParameter]?, headers: [Header]?, bodies: [Body]?
    ) -> AnyPublisher<(data: Data, response: URLResponse, decoded: T), Error>
}

extension MoonlightContract {
    
    func requestWithAsyncAwait<T: Decodable>(
        for url: String, responseType: T.Type? = nil, requestType: HTTPMethod? = .get,
        queryParameters: [QueryParameter]? = nil, headers: [Header]? = nil, bodies: [Body]? = nil
    ) async throws -> (data: Data, response: URLResponse, decoded: T) {
        fatalError("Default implementation, should be overridden by conforming types")
    }
    
    func requestWithCombine<T: Decodable>(
        for url: String, responseType: T.Type? = nil, requestType: HTTPMethod? = .get,
        queryParameters: [QueryParameter]? = nil, headers: [Header]? = nil, bodies: [Body]? = nil
    ) -> AnyPublisher<(data: Data, response: URLResponse, decoded: T), Error> {
        fatalError("Default implementation, should be overridden by conforming types")
    }
}
