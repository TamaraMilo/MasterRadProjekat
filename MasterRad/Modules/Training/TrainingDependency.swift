//
//  TrainingDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

protocol TrainingInjectable {
    var training: Training { get }
}

final class TrainingDependency: TrainingInjectable {
    var training: Training
    
    init(training: Training) {
        self.training = training
    }
}
