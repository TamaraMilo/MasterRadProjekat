//
//  TrainingCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import SwiftUI

protocol TrainingCoordinable: Coordinable {}

class TrainingCoordinator<Dependency> where Dependency: TrainingDependency {
    var dependency: Dependency
    @Binding var training: Training

    init(dependency: Dependency, training: Binding<Training>) {
        self.dependency = dependency
        self._training = training
    }
    
    var view: AnyView {
        AnyView(
            TrainingView(
                viewModel: TreningViewModel(
                    userWebRepository: dependency.userWebRepository,
                    authWebRepository: dependency.authWebRepository,
                    trainingId: ""
                )
            )
        )
    }
}

extension TrainingCoordinator: TrainingCoordinable { }
