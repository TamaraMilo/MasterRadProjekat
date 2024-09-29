//
//  TrainingListViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation

final class TrainingListViewModel: ObservableObject {
 
    @Published var trainings: [Training] = [
        Training.fixtureTraining1(),
        Training.fixtureTraining2(),
        Training.fixtureTraining3(),
        Training.fixtureTraining4(),
        Training.fixtureTraining5(),
        Training.fixtureTraining6(),
        Training.fixtureTraining7(),
    ]
}
