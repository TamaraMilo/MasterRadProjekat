//
//  RootCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import SwiftUI

protocol RootCoordinable: Coordinable {
    var loginCoordinator: any LoginCoordinable { get }
    var applicationCoordinator: any ApplicationCoordinable { get }
}

class RootCoordinator<Dependency> where Dependency: RootInjectable {
    
    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    var view: AnyView {
        AnyView(
            RootView(
                viewModel: RootViewModel(
                    authWebRepository: dependency.authWebRepository,
                    rootEventTracker: dependency.rootEventTracker
                ),
                loginCoordinator: loginCoordinator,
                registerCoordinator: registerCoordinator,
                applicationCoordinator: applicationCoordinator
            )
            .environmentObject(dependency.sharedData)
        )
    }
}

extension RootCoordinator: RootCoordinable {
    
    var loginCoordinator: any LoginCoordinable {
        let dependency = LoginDependency(
            webRepository: dependency.authWebRepository,
            rootEventTracker: dependency.rootEventTracker
        )
        return LoginCoordinator(dependency: dependency)
    }
    
    var applicationCoordinator: any ApplicationCoordinable {
        let dependency = ApplicationDependency(
            rootEventTracker: dependency.rootEventTracker,
            userWebRepository: dependency.userWebRepository,
            authWebRepository: dependency.authWebRepository
        )
        return ApplicationCoordinator(dependency: dependency)
    }
    
    var registerCoordinator: any RegisterCoordinable {
        let dependency = RegisterDependency(
            rootEventTracker:dependency.rootEventTracker,
            authWebRepository: dependency.authWebRepository,
            userWebRepository: dependency.userWebRepository
        )
        return RegisterCoordinator(dependency: dependency)
    }
    
}

