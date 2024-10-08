//
//  TrainingListDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation
protocol TrainingListInjectable {
    var trainingWebRepository: TrainingRepository { get }
}

class TrainingListDependency: TrainingListInjectable {
    
    var trainingWebRepository: TrainingRepository
    
    init(trainingWebRepository: TrainingRepository) {
        self.trainingWebRepository = trainingWebRepository
    }
}
