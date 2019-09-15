//
//  ExampleRequest.swift
//  SimpleAPIKitExample
//
//  Created by shiuchi on 2019/09/14.
//  Copyright © 2019 shiuchi. All rights reserved.
//

import Foundation
import SimpleAPIKit

struct ExampleResponse: Decodable {
    let title: String
    let pinpointLocations: [City]
    
    enum CodingKeys: String, CodingKey {
        case title, pinpointLocations
    }
    
    struct City: Decodable {
        let link: URL
        let name: String
        
        enum COdingKeys: String, CodingKey {
            case link, name
        }
    }
}


/// http://weather.livedoor.com/forecast/webservice/json/v1?city=400040
struct ExampleRequest: Request {
    typealias Response = ExampleResponse
    typealias Serializer = DecodableSerializer<Response>
    let schame: Schame = .http
    let hosts: Hosts = .example
    let path: String = "/forecast/webservice/json/v1"
    let method: HTTPMethod = .get
    var query: [String : String]? {
        return [ "city": city ]
    }
    let city: String
}


