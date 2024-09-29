//
//  VendorCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation
import SwiftUI

protocol VendorCoordinable: Coordinable {
    var createTrainingCoordinator: any CreateTrainingCoordinable { get }
    var trainingListCoordinator: any TrainingListCoordinable { get }
}

class VendorCoordinator<Dependency> where Dependency: VendorInjectable {
    var dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            VendorView(
                viewModel: VendorViewModel(
                    authWebRepository: dependency.authWebRepository,
                    rootEventTracker: dependency.rootEventTracker
                ), coordinator: self
            )
            .environmentObject(dependency.sharedData)
        )
    }
}

extension VendorCoordinator: VendorCoordinable {
    var createTrainingCoordinator: any CreateTrainingCoordinable {
        let dependency = CreateTrainingDependency()
        return CreateTrainingCoordinator(dependency: dependency)
    }
    
    var trainingListCoordinator: any TrainingListCoordinable {
        let dependency = TrainingListDependency(
            trainingWebRepository: dependency.trainingWebRepository
        )
        return TrainingListCoordinator(dependency: dependency)
    }
    
}
