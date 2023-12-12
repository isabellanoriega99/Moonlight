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
        for url: String, decodeType: T.Type?, requestType: HTTPMethod?,
        queryParameters: [QueryParameter]?, headers: [Header]?, bodies: [Body]?
    ) async throws -> T
    
    func requestWithCombine<T: Decodable>(
        for url: String, decodeType: T.Type?, requestType: HTTPMethod?,
        queryParameters: [QueryParameter]?, headers: [Header]?, bodies: [Body]?
    ) -> AnyPublisher<T, Error>
}

extension MoonlightContract {
    
    func requestWithAsyncAwait<T: Decodable>(
        for url: String, decodeType: T.Type? = nil, requestType: HTTPMethod? = .get,
        queryParameters: [QueryParameter]? = nil, headers: [Header]? = nil, bodies: [Body]? = nil
    ) async throws -> T {
        fatalError("Default implementation, should be overridden by conforming types")
    }
    
    func requestWithCombine<T: Decodable>(
        for url: String, decodeType: T.Type? = nil, requestType: HTTPMethod? = .get,
        queryParameters: [QueryParameter]? = nil, headers: [Header]? = nil, bodies: [Body]? = nil
    ) -> AnyPublisher<T, Error> {
        fatalError("Default implementation, should be overridden by conforming types")
    }
}
