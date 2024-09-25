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
    func makeTrainerCoordinator(trainer: Trainer) -> any TrainerCoordinable
    func makeTrainingCoordinator(training: Training) -> any TrainingCoordinable
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
        let dependency = ProfileDependency(rootEventTracker: dependency.rootEventTracker)
        return ProfileCoordinator(dependency: dependency)
    }
    
    func makeTrainerCoordinator(trainer: Trainer) -> any TrainerCoordinable {
        TrainerCoordinator(dependency: TrainerDependency(trainer: trainer))
    }
    
    func makeTrainingCoordinator(training: Training) -> any TrainingCoordinable {
        TrainingCoordinator(dependency: TrainingDependency(training: training))
    }
}
