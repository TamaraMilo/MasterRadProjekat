//
//  TrainingListViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation
import Combine

final class TrainingListViewModel: ObservableObject {
 
    @Published var state: State = .idle
    @Published var trainings: [Training] = [
        Training.fixtureTraining1(),
        Training.fixtureTraining2(),
        Training.fixtureTraining3(),
        Training.fixtureTraining4(),
        Training.fixtureTraining5(),
        Training.fixtureTraining6(),
        Training.fixtureTraining7(),
    ]
    
    private let trainingWebRepository: TrainingRepository
    private var disposables = Set<AnyCancellable>()
    
    init(trainingWebRepository: TrainingRepository) {
        self.trainingWebRepository = trainingWebRepository
    }
    
    func fetchTrainings() {
        trainingWebRepository.getTrainings()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:break
                case .failure(let failure):
                    print(failure)
                }
            }, receiveValue: { [weak self] data in
                guard let self else { return }
                trainings = data
            })
            .store(in: &disposables)
    }
}

extension TrainingListViewModel {
    enum State {
        case idle
        case loading
        case ready
        case error
    }
}
