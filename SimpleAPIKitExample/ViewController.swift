//
//  ViewController.swift
//  SimpleAPIKitExample
//
//  Created by shiuchi on 2019/09/14.
//  Copyright © 2019 shiuchi. All rights reserved.
//

import UIKit
import SimpleAPIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.shared.send(request: ExampleRequest(city: "400040")) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }


}

