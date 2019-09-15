//
//  AppDelegate.swift
//  SimpleAPIKitExample
//
//  Created by shiuchi on 2019/09/14.
//  Copyright © 2019 shiuchi. All rights reserved.
//

import UIKit
import SimpleAPIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup(launchOptions)
        return true
    }

    private func setup(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        APIClient.shared.logic = ExampleNetworkClient()
    }

}

