//
//  APIClient.swift
//  SimpleAPIKit
//
//  Created by shiuchi on 2019/09/13.
//  Copyright © 2019 shiuchi. All rights reserved.
//

import Foundation

public final class APIClient {
    
    public static var shared = APIClient()
    public var logic: NetworkClient?
    
    private init() {
    }
    
    public func send<T: Request>(request: T, completion: @escaping (Result<T.Response, Error>) -> Void) {
        logic?.send(request: request, completion: completion)
    }
}

/// API Requestを行う各種クラスに対してその差分を吸収するProctol
public protocol NetworkClient {
    func send<T: Request>(request: T, completion: @escaping (Result<T.Response, Error>) -> Void)
}

public enum APIClientError: Error {
    case unknown
    case timeout
    case informational(Int, String)
    case redirection(Int, String)
    case clientError(Int, String)
    case serverError(Int, String)
    
    init?(httpResponse: HTTPURLResponse) {
        let statusCode = httpResponse.statusCode
        let message = HTTPURLResponse.localizedString(forStatusCode: statusCode)
        switch statusCode {
        case 100..<200:
            self = .informational(statusCode, message)
        case 200..<300:
            return nil
        case 300..<400:
            self = .redirection(statusCode, message)
        case 400..<500:
            self = .clientError(statusCode, message)
        case 500..<600:
            self = .serverError(statusCode, message)
        default:
            self = .unknown
        }
    }
}
