//
//  TrainingListCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation
import SwiftUI

protocol TrainingListCoordinable: Coordinable {
    
}

final class TrainingListCoordinator<Dependency> where Dependency: TrainingListInjectable {
    
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            TrainingListView(
                viewModel: TrainingListViewModel(
                    trainingWebRepository: dependency.trainingWebRepository
                )
            )
        )
    }
}

extension TrainingListCoordinator: TrainingListCoordinable {
    
}
