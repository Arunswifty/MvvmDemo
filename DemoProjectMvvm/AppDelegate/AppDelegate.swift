//
//  AppDelegate.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 17/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import UIKit
import RealmSwift

let RObject = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //
        return true
    }
}
