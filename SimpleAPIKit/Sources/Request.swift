//
//  Request.swift
//  SimpleAPIKit
//
//  Created by shiuchi on 2019/09/13.
//  Copyright © 2019 shiuchi. All rights reserved.
//

public protocol Request {
    associatedtype Response
    associatedtype Serializer: DataSerializer where Self.Serializer.SerializedObject == Self.Response
    
    var schame: Schame { get }
    var hosts: Hosts { get }
    var path: String { get }
    var url: URL { get }
    var header: [String: String]? { get }
    var query: [String: String]? { get }
    var serializer: Serializer { get }
    var method: HTTPMethod { get }
}

extension Request where Self.Serializer == DecodableSerializer<Self.Response> {
    public var serializer: Serializer { return DecodableSerializer<Response>() }
}

extension Request where Self.Serializer == JSONSerializer<Self.Response> {
    public var serializer: Serializer { return JSONSerializer<Response>() }
}

extension Request {
    public var query: [String: String]? { return nil }
    public var header: [String: String]? { return nil }
    var httpBody: Data? { return nil }
    var method: HTTPMethod { return .get }
    var schame: Schame { return .https }
    public var url: URL {
        let urlString =  schame.rawValue + hosts.rawValue + path
        var urlComponents = URLComponents(string: urlString)!
        if let query = query {
            var queryItems = urlComponents.queryItems ?? []
            for (key, value) in query {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            urlComponents.queryItems = queryItems
        }
        return urlComponents.url!
    }
}

public struct Hosts: RawRepresentable {
    public typealias RawValue = String
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: RawValue) {
        self.init(rawValue: rawValue)
    }
}

public struct Schame: RawRepresentable {
    public typealias RawValue = String
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

public extension Schame {
    static let http = Schame("http://")
    static let https = Schame("https://")
}

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}
