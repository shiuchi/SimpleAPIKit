# SimpleAPIKit
Simple APIKit for Swift

## Description
Simple APIKit that supports Decodable and JSONSerialization.

## Features
* Support Decodable., JSONObject

## Example

```swift
// Create Request and Response.
struct ExampleResponse: Decodable {
    let id: String
    let name: String
    let age: Int

    enum COdingKeys: String, CodingKey {
        case id, name, age
    }
}

struct ExampleRequest: Request {
    typealias Response = ExampleResponse
    typealias Serializer = DecodableSerializer<Response>
    let schame: Schame = .https
    let hosts: Hosts = .example
    let path: String = "/user"
    let method: HTTPMethod = .get
    var query: [String : String]? {
        return [ "id": id ]
    }
    
    let id: Int
}

// Set the class that implements NetworkClient to APIClient.shared.logic.
APIClient.shared.logic = ExampleNetworkClient()

// send request and get response.
override func viewDidLoad() {
    super.viewDidLoad()
    APIClient.shared.send(request: ExampleRequest(id: 0000)) { result in
        switch result {
            case .success(let data):
            print(data)
            case .failure(let error):
            print(error)
        }
    }
}
```

## Installation


## Author

shiuchi

## License

MIT
