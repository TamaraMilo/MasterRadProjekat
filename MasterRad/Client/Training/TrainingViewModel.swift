//
//  TrainingView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import SwiftUI
import Combine

final class TreningViewModel: ObservableObject {
    
    @Published var state: State = .idle
    @Published var training: Training = Training()
    var trainingId: String
    //@Published var training2: Training
    @Published var isAlreadyInTraining:Bool = false
    
    private var disposables = Set<AnyCancellable>()
    private var userWebRepository: UserRepository
    private var authWebRepository: AuthRepository
    private var trainingWebRepository = TrainingWebRepository()
    
    var user: UserData = UserData()
    
    init(
        userWebRepository: UserRepository,
        authWebRepository: AuthRepository,
        trainingId: String
    ) {
        self.userWebRepository = userWebRepository
        self.authWebRepository = authWebRepository
        self.trainingId = trainingId
    }
    
    func addUserToTrain() {
        if training.participants.contains(where: { $0.id == user.id}) {
            print("Already signed")
            isAlreadyInTraining = true
        } else {
            isAlreadyInTraining = true
            training.participants.append(user)
        }
        print(training.participants)
    }
    
    func removeUserFromTraining() {
        training.participants.removeAll(where: { $0.id == user.id })
        isAlreadyInTraining = false
    }
    
    
    func fetchData() {
        guard let user = authWebRepository.user else { return }
        let trainingPublisher =  trainingWebRepository.getTraining(id: trainingId)
        let userPublisher = userWebRepository.getUserData(id: user.uid)
        state = .loading
        Publishers.Zip(trainingPublisher, userPublisher)
            .sink(receiveCompletion: {result in
                switch result {
                case .finished: break
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }, receiveValue:{[weak self] training, user in
                guard let self, let user, let training else { return }
                self.training = training
                self.user = user
                state = .ready
            })
            .store(in: &disposables)
    }
}

extension TreningViewModel {
    enum State {
        case idle
        case loading
        case ready
        case error
    }
}
