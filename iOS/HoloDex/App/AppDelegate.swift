//
//  AppDelegate.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import UIKit
import ReSwift
import ReSwiftRouter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var store: Store<AppState>!
  var router: Router<AppState>!

  // MARK: - App Delegate Methods

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    //let swapi = StarWarsAPI()
    let middleware = createMiddlewareChain(items: [fetchPeople(peopleService: StaticPeopleService())])
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.store = Store<AppState>(reducer: appReducer, state: nil, middleware: [middleware])

    // Set a dummy view controller to satisfy UIKit
    window?.rootViewController = UIViewController()

    let rootRoutable = RootAppRoutable(store: store, window: window!)

    // Set Router
    router = Router<AppState>(store: store, rootRoutable: rootRoutable) {
      $0.select {
        $0.navigationState
      }
    }

    store.dispatch(SetRouteAction([AppRoutes.home.rawValue, AppRoutes.people.rawValue]))
    // TODO: Dispatch a FetchPeople request when navigating to the People tab.
    store.dispatch(PeopleActions.FetchPeople.request(page: 1))

    window?.makeKeyAndVisible()
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
