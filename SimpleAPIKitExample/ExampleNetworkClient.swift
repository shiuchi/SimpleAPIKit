//
//  ExampleNetworkClient.swift
//  SimpleAPIKitExample
//
//  Created by shiuchi on 2019/09/14.
//  Copyright © 2019 shiuchi. All rights reserved.
//

import Foundation
import SimpleAPIKit

final class URLSessionClient: NetworkClient {
    
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
