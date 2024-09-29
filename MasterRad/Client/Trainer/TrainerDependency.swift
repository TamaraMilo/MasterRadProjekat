//
//  TrainerDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

protocol TrainerInjectable {
    var trainer: Trainer { get }
}

final class TrainerDependency: TrainerInjectable {
    var trainer: Trainer
    
    init(trainer: Trainer) {
        self.trainer = trainer
    }
}
