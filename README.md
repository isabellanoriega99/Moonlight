# Moonlight
The Moonlight Library, created with Swift Package Manager, offers a quick implementation for network requests. You have the option of choosing between two functions each time you want to make an API call. Each of the functions will be thouroughly explained below. This library uses URLSessions and JSONDecoder.

## Types of Requests and More:
- [Requests using Async/Await](#async_throw)
- [Requests using Combine](#combine)
- [Structs you need to know](#structs)


## Requests using Async/Await
Description: Performs an asynchronous network request that can throw errors.

```swift
Moonlight.requestWithAsyncAwait(for url: String, responseType: T.Type?, requestType: HTTPMethod?,
                                queryParameters: [QueryParameter]?, headers: [Header]?, bodies: [Body]?) 
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

 - Returns: A decoded object. 

## Requests using Combine
Description: Creates a Combine publisher for an asynchronous network request.

```swift
Moonlight.requestWithCombine(for url: String, responseType: T.Type?, requestType: HTTPMethod?,
                            queryParameters: [QueryParameter]?, headers: [Header]?, bodies: [Body]?)
```
- Parameters:
   - url: The URL for the network request.
   - responseType: The type of the expected response (Decodable).
   - requestType: The HTTP request method (e.g., "GET", "POST").
   - queryParameters: Optional query parameters for the request.
   - headers: Optional headers for the request.
   - bodies: Optional request bodies.

 - Returns: A Combine publisher emitting decoded object.

## Structs you need to know

- QueryParameter = QueryParameter(key: "param", value: "value")
- Header = Header(name: "type", value: "Bearer token")
- Body = Body(content: String)
- HTTPMethod = is an enum with all the httpMethods accepted by URLSessions (.get, .post, ...)

These are examples of what the structs can contain, however they allow any type
of "name", "value", "content", as long as they are supported by
URLSession.
