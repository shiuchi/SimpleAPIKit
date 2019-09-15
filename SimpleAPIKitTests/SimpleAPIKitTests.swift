//
//  SimpleAPIKitTests.swift
//  SimpleAPIKitTests
//
//  Created by shiuchi on 2019/09/13.
//  Copyright © 2019 shiuchi. All rights reserved.
//

import XCTest
@testable import SimpleAPIKit

class SimpleAPIKitTests: XCTestCase {

    override func setUp() {
        APIClient.shared.logic = ExampleNetworkClient()
    }

    func testSend() {
        let APIexpectation = expectation(description: "success")
        APIClient.shared.send(request: MockSuccessRequest(id: 247077)) { result in
            XCTAssertNotNil(result)
            XCTAssertTrue(result.isSuccess)
            APIexpectation.fulfill()
        }
        self.waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSendFailure() {
        let APIexpectation = expectation(description: "failure")
        APIClient.shared.send(request: MockFailureRequest.init()) { result in
            XCTAssertNotNil(result)
            XCTAssertTrue(result.isFailure)
            APIexpectation.fulfill()
        }
        self.waitForExpectations(timeout: 3, handler: nil)
    }

}

extension Result {
    var isSuccess: Bool {
        switch self{
        case .success(_): return true
        case .failure(_): return false
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
}

class ExampleNetworkClient: NetworkClient {
    
    func send<T>(request: T, completion: @escaping (Result<T.Response, Error>) -> Void) where T : Request {
        let url = request.url
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let _ = self else {
                return
            }
            
            if let data = data {
                completion(request.serializer.serialize(data: data))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(APIClientError.unknown))
            }
            
        }
        task.resume()
    }
}

private extension Hosts {
    static let metmuseum = Hosts("collectionapi.metmuseum.org")
}

struct MockSuccessRequest: Request {
    public typealias Response = Item
    public typealias Serializer = DecodableSerializer<Response>
    
    public var hosts: Hosts { return Hosts.metmuseum }
    public var path: String { return "/public/collection/v1/objects/\(id)" }
    public var query: [String: String]? { return nil}
    public var method: HTTPMethod { return .get }
    public let id: Int
    
    public init(id: Int){
        self.id = id
    }
}

public struct Item: Decodable {
    
    public let title: String
    public let artistDisplayName: String
    public let primaryImageSmall: String
    
    public enum CodingKeys: String, CodingKey {
        case title
        case artistDisplayName
        case primaryImageSmall
    }
}

struct MockFailureRequest: Request {
    typealias Response = MockResponse
    typealias Serializer = DecodableSerializer<Response>
    
    var hosts: Hosts { return Hosts.metmuseum }
    var path: String { return "/api/hogehogehoge" }
    var query: [String: String]? { return [
        "message": ""
        ] }
    public var method: HTTPMethod { return .get }
    
    public init(){}
}

struct  MockResponse: Decodable {
    let hoge: String
    let fuga: String
    
    enum CodingKeys: String, CodingKey {
        case hoge
        case fuga
    }
    
}
