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
                viewModel: RootViewModel(rootEventTracker: dependency.rootEventTracker),
                loginCoordinator: loginCoordinator,
                applicationCoordinator: applicationCoordinator
            )
            .environmentObject(dependency.sharedData)
        )
    }
}

extension RootCoordinator: RootCoordinable {
    
    var loginCoordinator: any LoginCoordinable {
        let dependency = LoginDependency(webRepository: AuthWebRepository(), rootEventTracker: dependency.rootEventTracker)
        return LoginCoordinator(dependency: dependency)
    }
    
    var applicationCoordinator: any ApplicationCoordinable {
        let dependency = ApplicationDependency(rootEventTracker: dependency.rootEventTracker)
        return ApplicationCoordinator(dependency: dependency)
    }
    
}

