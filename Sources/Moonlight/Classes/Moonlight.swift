//
//  File.swift
//  
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation
import Combine

class Moonlight: MoonlightContract {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func requestWithAsyncNoThrow<T: Decodable>(for url: String,
                                               responseType: T.Type?,
                                               requestType: String = "GET",
                                               queryParameters: [QueryParameter]?,
                                               headers: [Header]?,
                                               bodies: [Body]?) async -> (data: Data?,
                                                                          response: URLResponse?, decoded: T?) {
        guard let request = buildRequest(url: url,
                                   requestType: requestType,
                                   queryParameters: queryParameters,
                                   headers: headers,
                                         bodies: bodies) else {
            print("InvalidURL")
            return (data: nil, response: nil, decoded: nil)
        }
        do {
            let (data, response) = try await session.data(for: request)
            let decoded = try decoder.decode(T.self, from: data)
            return (data: data, response: response, decoded: decoded)
        } catch {
            print(error)
            return (data: nil, response: nil, decoded: nil)
        }
    }

    func requestWithAsyncThrows<T: Decodable>(for url: String,
                                              responseType: T.Type?,
                                              requestType: String = "GET",
                                              queryParameters: [QueryParameter]?,
                                              headers: [Header]?,
                                              bodies: [Body]?) async throws -> (data: Data,
                                                                                response: URLResponse, decoded: T) {
        guard let request = buildRequest(url: url,
                                   requestType: requestType,
                                   queryParameters: queryParameters,
                                   headers: headers,
                                         bodies: bodies) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(for: request)
        let decoded = try decoder.decode(T.self, from: data)
        return (data: data, response: response, decoded: decoded)
    }

    func requestWithCombine<T: Decodable>(for url: String,
                                          responseType: T.Type?,
                                          requestType: String = "GET",
                                          queryParameters: [QueryParameter]?,
                                          headers: [Header]?,
                                          bodies: [Body]?) -> AnyPublisher<(data: Data,
                                                                            response: URLResponse, decoded: T), Error> {
        guard let request = buildRequest(url: url,
                                   requestType: requestType,
                                   queryParameters: queryParameters,
                                   headers: headers,
                                         bodies: bodies) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                let decoded = try self.decoder.decode(T.self, from: data)
                return (data: data, response: response, decoded: decoded)
            }
            .mapError { error in
                return NetworkError.requestFailed(error)
            }
            .eraseToAnyPublisher()
    }

    private func buildRequest(url: String,
                              requestType: String,
                              queryParameters: [QueryParameter]?,
                              headers: [Header]?,
                              bodies: [Body]?) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        
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

        return request
    }

    private func addQueryParameters(queryParameters: [QueryParameter]?) -> [URLQueryItem]? {

        if let queryParameters = queryParameters {
            return queryParameters.map { URLQueryItem(name: $0.name, value: $0.value) }
        }
        return nil
    }

}
