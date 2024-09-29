//
//  LoginCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import SwiftUI

protocol LoginCoordinable: Coordinable {
}

class LoginCoordinator<Dependency> where Dependency: LoginDependency {
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            LoginView(
                viewModel: LoginViewModel(
                    webRepository: dependency.webRepository,
                    rootEventTracker: dependency.rootEventTracker,
                    userWebRepository: dependency.userWebRepository
                )
            )
        )
    }
}

extension LoginCoordinator: LoginCoordinable {
    
}
