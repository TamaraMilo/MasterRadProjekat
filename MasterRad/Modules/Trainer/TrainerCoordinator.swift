//
//  TrainerCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import SwiftUI

protocol TrainerCoordinable: Coordinable {}

class TrainerCoordinator<Dependency> where Dependency: TrainerDependency {
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            TrainerView(trainer: dependency.trainer)
        )
    }
}

extension TrainerCoordinator: TrainerCoordinable { }
