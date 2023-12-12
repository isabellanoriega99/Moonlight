# Moonlight
The Moonlight Library offers a quick implementation for network requests. You have the option of choosing between three functions each time you want to make an API call. Each of the functions will be thouroughly explained below. This library uses URLSessions and JSONDecoder.

## Types of Requests and More:
- [Requests using Async/Await with no throw](#async_no_throw)
- [Requests using Async/Await with throw](#async_throw)
- [Requests using Combine](#combine)
- [Structs you need to know](#structs)

## Requests using Async/Await with no throw
Description: Performs an asynchronous network request without throwing errors.

```swift 
func requestWithAsyncNoThrow<T: Decodable>(for url: String,
                                               responseType: T.Type?,
                                               requestType: String,
                                               queryParameters: [QueryParameter]?,
                                               headers: [Header]?,
                                               bodies: [Body]?) async -> (data: Data?,
                                                                          response: URLResponse?, decoded: T?)
```
Parameters:
   - url (Type: String) - The URL for the network request.
   - responseType (Type: T.Type?) - The type of the expected response (Decodable).
   - requestType (Type: String) - The HTTP request method with "GET" set as default (e.g., "GET", "POST").
   - queryParameters (Type: [QueryParameter]?) - Optional query parameters for the request.
   - headers (Type: [Header]?) - Optional headers for the request.
   - bodies (Type: [Body]?) - Optional request bodies.
 
 Returns:
   - Type: (data: Data?, response: URLResponse?, decoded: T?) - A tuple containing the data,
     response, and decoded object.

## Requests using Async/Await with throw
Description: Performs an asynchronous network request that can throw errors.

```swift
func requestWithAsyncThrows<T: Decodable>(for url: String,
                                              responseType: T.Type?,
                                              requestType: String,
                                              queryParameters: [QueryParameter]?,
                                              headers: [Header]?,
                                              bodies: [Body]?) async throws -> (data: Data,
                                                                                response: URLResponse, decoded: T)
```
 Performs an asynchronous network request that can throw errors.

 - Parameters:
   - url: The URL for the network request.
   - responseType: The type of the expected response (Decodable).
   - requestType: The HTTP request method with "GET" set as default (e.g., "GET", "POST").
   - queryParameters: Optional query parameters for the request.
   - headers: Optional headers for the request.
   - bodies: Optional request bodies.

 - Throws: An error if the network request encounters an issue.

 - Returns: A tuple containing the data, response, and decoded object.

## Requests using Combine
Description: Creates a Combine publisher for an asynchronous network request.

```swift
func requestWithCombine<T: Decodable>(for url: String,
                                          responseType: T.Type?,
                                          requestType: String,
                                          queryParameters: [QueryParameter]?,
                                          headers: [Header]?,
                                          bodies: [Body]?) -> AnyPublisher<(data: Data,
                                                                            response: URLResponse, decoded: T), Error>
```
- Parameters:
   - url: The URL for the network request.
   - responseType: The type of the expected response (Decodable).
   - requestType: The HTTP request method (e.g., "GET", "POST").
   - queryParameters: Optional query parameters for the request.
   - headers: Optional headers for the request.
   - bodies: Optional request bodies.

 - Returns: A Combine publisher emitting a tuple containing the data, response,
   and decoded object.

## Structs you need to know

- QueryParameter = QueryParameter(key: "param", value: "value")
- Header = Header(name: "type", value: "Bearer token")
- Body = Body(contentType: "application/json", data: jsonData)

These are examples of what the structs can contain, however they allow any type
of "name", "value", "contentType", and "data", as long as they are supported by
URLSession.
