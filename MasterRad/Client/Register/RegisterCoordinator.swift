//
//  RegisterCoordinator.swift
//  MasterRad
//
//  Created by Tamara Milovanovic on 24.9.24..
//

import Foundation
import SwiftUI

protocol RegisterCoordinable: Coordinable {
    
}

final class RegisterCoordinator<Dependency> where Dependency: RegisterInjectable {
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            RegisterView(
                viewModel: RegisterViewModel(
                    authWebRepository: dependency.authWebRepository,
                    userWebRepository: dependency.userWebRepository,
                    rootEventTracker: dependency.rootEventTracker
                )
            )
        )
    }
    
}

extension RegisterCoordinator: RegisterCoordinable {
    
}
