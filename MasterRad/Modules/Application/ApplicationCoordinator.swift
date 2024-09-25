//
//  ApplicationCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import SwiftUI

protocol ApplicationCoordinable: Coordinable {
    var profileCoordinator: any ProfileCoordinable { get }
    var trainerCoordinator: any TrainerCoordinable { get }
    var trainingCoordinator: any TrainingCoordinable { get }
}

class ApplicationCoordinator<Dependency> where Dependency: ApplicationDependency {
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            ApplicationView(
                viewModel: ApplicationViewModel(rootEventTracker: dependency.rootEventTracker),
                coordinator: self
            )
//            .environmentObject(dependency.sharedData)
        )
    }
}

extension ApplicationCoordinator: ApplicationCoordinable {
    var profileCoordinator: any ProfileCoordinable {
        let dependency = ProfileDependency(
            userWebRepository: dependency.userWebRepository,
            authWebRepository: dependency.authWebRepository,
            rootEventTracker: dependency.rootEventTracker
        )
        return ProfileCoordinator(dependency: dependency)
    }
    
    var trainerCoordinator: any TrainerCoordinable {
        TrainerCoordinator(dependency: TrainerDependency())
    }
    
    var trainingCoordinator: any TrainingCoordinable {
        TrainingCoordinator(dependency: TrainingDependency())
    }
    
    
}
