//
//  MasterRadApp.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MasterRadApp: App {
    let coordinator: any RootCoordinable

    init() {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        let tracker: RootEventTracker = RootEventTracker()
        let sharedData: SharedData = SharedData()
        let dependency: RootDependency = RootDependency(rootEventTracker: tracker, sharedData: sharedData)
        coordinator = RootCoordinator(dependency: dependency)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.view
        }
    }
}
