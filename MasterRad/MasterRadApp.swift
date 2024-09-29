//
//  MasterRadApp.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import SwiftUI
import FirebaseCore

@main
struct MasterRadApp: App {
    let coordinator: any RootCoordinable

    init() {
        FirebaseApp.configure()
        let tracker: RootEventTracker = RootEventTracker()
        let sharedData: SharedData = SharedData()
        let authWebRepository: AuthWebRepository = AuthWebRepository()
        let userWebRepository: UserWebRepository = UserWebRepository()
        let trainingWebRepository = TrainingWebRepository()
        let dependency: RootDependency = RootDependency(
            authWebRepository: authWebRepository,
            rootEventTracker: tracker,
            sharedData: sharedData,
            userWebRepository: userWebRepository,
            trainingWebRepository: trainingWebRepository
        )
        coordinator = RootCoordinator(dependency: dependency)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.view
        }
    }
}
