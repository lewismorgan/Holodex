//
//  AppDelegate.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Swinject
import UIKit
import XCoordinator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  let window: UIWindow! = UIWindow()
  let router: AnyRouter<AppRoute>
  var container: Swinject.Container

  // MARK: - Init

  override init() {
    // Setup the container based on the container environment variable for the process
    if let containerType = ProcessInfo.processInfo.environment["container"] {
      // The container that should be used was specified, so pull it from the factory
      self.container = HoloDexContainerFactory.fromRaw(value: containerType)
      print("⚙️ Using container", containerType)
    } else {
      self.container = HoloDexContainerFactory.create(type: .release)
    }
    // Setup the router
    self.router = AppCoordinator(container: self.container).anyRouter
    super.init()
  }

  // MARK: - AppDelegate

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    router.setRoot(for: window)
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
    //  or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
    // Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers,
    //  and store enough application state information to restore your application to its current state
    //  in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate
    //  when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state;
    //  here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive.
    // If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate.
    // See also applicationDidEnterBackground:.
  }
}
