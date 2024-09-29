//
//  CreateTrainingViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation
final class CreateTrainingViewModel: ObservableObject {
    @Published var training: Training = Training()
    var trainingWebRepository = TrainingWebRepository()
    
    func createTraining() {
        trainingWebRepository.createTraining(name: training.name, date: training.date, time: training.time, trainer: training.trainer, description: training.description)
    }
}
