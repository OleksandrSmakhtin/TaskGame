//
//  AppDelegate.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // get urls
        let beenLaunched = UserDefaults.standard.bool(forKey: K.firstLaunch)
        if !beenLaunched {
            NetworkManager.shared.getUrls()
            UserDefaults.standard.set(true, forKey: K.firstLaunch)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

