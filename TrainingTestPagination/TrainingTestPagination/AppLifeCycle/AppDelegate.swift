//
//  AppDelegate.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    class func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

