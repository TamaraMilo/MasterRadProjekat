//
//  ProfileCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import SwiftUI

protocol ProfileCoordinable: Coordinable {}

class ProfileCoordinator<Dependency> where Dependency: ProfileDependency {
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            ProfileView(
                viewModel: ProfileViewModel(
                    userWebRepository: dependency.userWebRepository,
                    authWebRepository: dependency.authWebRepository,
                    rootEventTracker: dependency.rootEventTracker
                )
            )
        )
    }
}

extension ProfileCoordinator: ProfileCoordinable { }
