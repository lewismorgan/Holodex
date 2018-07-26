//
//  AppDelegate.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import Katana
import Tempura

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RootInstaller {
  var window: UIWindow?
  var store: Store<AppState>!

  // MARK: - App Delegate Methods

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.store = Store<AppState>(middleware: [], dependencies: DependenciesContainer.self)
    self.window = UIWindow(frame: UIScreen.main.bounds)

    /// setup the root of the navigation
    /// this is done by invoking this method (and not in the init of the navigator)
    /// because the navigator is instantiated by the Store.
    /// this in turn will invoke the `installRootMethod` of the rootInstaller (self)
    let navigator: Navigator! = (self.store!.dependencies as! DependenciesContainer).navigator
    navigator.start(using: self, in: self.window!, at: Screen.first)

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

  // MARK: - Routing

  /// install the root of the app
  /// this method is called by the navigator when needed
  func installRoot(identifier: RouteElementIdentifier, context: Any?, completion: () -> Void) {
    if identifier == Screen.first.rawValue {
      let rootController = UIViewController()
      rootController.view = UIView()
      rootController.view.backgroundColor = .green
      self.window?.rootViewController = rootController
      completion()
    }
  }
}
