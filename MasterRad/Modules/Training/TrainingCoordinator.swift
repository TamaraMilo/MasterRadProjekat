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

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            TrainingView()
        )
    }
}

extension TrainingCoordinator: TrainingCoordinable { }
