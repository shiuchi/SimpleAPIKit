//
//  Serializer.swift
//  SimpleAPIKit
//
//  Created by shiuchi on 2019/09/13.
//  Copyright © 2019 shiuchi. All rights reserved.
//

public protocol DataSerializer {
    associatedtype SerializedObject
    func serialize(data: Data) -> Result<SerializedObject, Error>
}

final public class DecodableSerializer<T: Decodable>: DataSerializer {
    public typealias SerializedObject = T
    public func serialize (data: Data) -> Result<SerializedObject, Error> {
        do {
            let dataResponse = try JSONDecoder().decode(SerializedObject.self, from: data)
            return Result.success(dataResponse)
        } catch let error {
            return Result.failure(error)
        }
    }
}

final public class JSONSerializer<T: JsonInitializable>: DataSerializer {
    public typealias SerializedObject = T
    public func serialize(data: Data) -> Result<SerializedObject, Error> {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JsonInitializable.JSON
            let data = SerializedObject(json: json)!
            return Result.success(data)
        } catch let error {
            return Result.failure(error)
        }
    }
}

public protocol JsonInitializable {
    typealias JSON = [String: AnyHashable]
    init?(json: JSON)
}
