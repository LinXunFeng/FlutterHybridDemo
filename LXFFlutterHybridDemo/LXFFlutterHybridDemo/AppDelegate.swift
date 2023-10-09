//
//  AppDelegate.swift
//  LXFFlutterHybridDemo
//
//  Created by LinXunFeng on 2023/3/16.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let engines = FlutterEngineGroup(name: "multiple-flutters", project: nil)
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
      
      GMSServices.provideAPIKey("xxxxxxx")
      
      
//      flutterEngine = FlutterEngine(name: "my flutter engine")
//      flutterEngine.run();
      
//      DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
//      {
//          GeneratedPluginRegistrant.register(with: self.flutterEngine);
//      })
    
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

