//
//  CreateTrainingCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation
import SwiftUI

protocol CreateTrainingCoordinable: Coordinable {
    
}

class CreateTrainingCoordinator<Dependency> where Dependency: CreateTrainingInjectable {
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            CreateTrainingView(viewModel: CreateTrainingViewModel())
        )
    }
}

extension CreateTrainingCoordinator: CreateTrainingCoordinable {
    
}
