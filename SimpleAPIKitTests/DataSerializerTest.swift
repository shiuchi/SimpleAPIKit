//
//  DataSerializerTest.swift
//  SimpleAPIKitTests
//
//  Created by shiuchi on 2019/09/15.
//  Copyright © 2019 shiuchi. All rights reserved.
//

import XCTest
@testable import SimpleAPIKit

class DataSerializerTest: XCTestCase {
    
    let mockTitle: String = "mocktitle"
    let mockArtistDisplayName: String = "mockartistDisplayName"
    let mockPrimaryImageSmall: String = "mockprimaryImageSmall"
    
    private lazy var mockdata = {
        return """
            {
            "title": "\(mockTitle)", "artistDisplayName": "\(mockArtistDisplayName)", "primaryImageSmall": "\(mockPrimaryImageSmall)"
            }
            """.data(using: .utf8)!
    }()
    
    func testDecodableSerializer() {
        let serializer = DecodableSerializer<Item>()
        let result = serializer.serialize(data: mockdata)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.isSuccess)
        
        if case .success(let data) = result {
            XCTAssertNotNil(data)
            XCTAssertEqual(data.title, mockTitle)
            XCTAssertEqual(data.artistDisplayName, mockArtistDisplayName)
            XCTAssertEqual(data.primaryImageSmall, mockPrimaryImageSmall)
            
        }
    }
}

