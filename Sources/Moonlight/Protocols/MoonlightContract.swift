//
//  File.swift
//  
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation
import Combine

//protocol MoonlightContract {
//
//    func request(for url: String,
//                 httpMethod: String,
//                 headers: [Header]?,
//                 queryParameters: [QueryParameter],
//                 bodies: [Body]?,
//                 with feature: FeatureType) async -> Any
//}

protocol MoonlightContract {

    func requestWithAsyncNoThrow<T: Decodable>(for url: String,
                                               responseType: T.Type?,
                                               requestType: String,
                                               queryParameters: [QueryParameter]?,
                                               headers: [Header]?,
                                               bodies: [Body]?) async -> (data: Data?,
                                                                          response: URLResponse?, decoded: T?)

    func requestWithAsyncThrows<T: Decodable>(for url: String,
                                              responseType: T.Type?,
                                              requestType: String,
                                              queryParameters: [QueryParameter]?,
                                              headers: [Header]?,
                                              bodies: [Body]?) async throws -> (data: Data,
                                                                                response: URLResponse, decoded: T)

    func requestWithCombine<T: Decodable>(for url: String,
                                          responseType: T.Type?,
                                          requestType: String,
                                          queryParameters: [QueryParameter]?,
                                          headers: [Header]?,
                                          bodies: [Body]?) -> AnyPublisher<(data: Data,
                                                                            response: URLResponse, decoded: T), Error>
}
