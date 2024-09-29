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
    @Binding var training: Training
    @Published var training2: Training
    @Published var isAlreadyInTraining:Bool = false
    
    private var disposables = Set<AnyCancellable>()
    private var userWebRepository: UserRepository
    private var authWebRepository: AuthRepository
    
    var user: UserData = UserData()
    
    init(
        userWebRepository: UserRepository,
        authWebRepository: AuthRepository,
        training: Binding<Training>
    ) {
        self.userWebRepository = userWebRepository
        self.authWebRepository = authWebRepository
        self._training = training
        self.training2 = training.wrappedValue
    }
    
    func addUserToTrain() {
        if training2.participants.contains(where: { $0.id == user.id}) {
            print("Already signed")
            isAlreadyInTraining = true
        } else {
            training2.participants.append(user)
            isAlreadyInTraining = true
            training.participants.append(user)
        }
        print(training.participants)
    }
    
    func removeUserFromTraining() {
        training2.participants.removeAll(where: { $0.id == user.id })
        isAlreadyInTraining = false
    }
    
    @MainActor
    func fetchUserData() async {
        guard let user = authWebRepository.user else { return }
        state = .loading
        let data =  await userWebRepository.getUserData(id: user.uid)
        if let data  {
            self.user = data
            state = .ready
        }
    }
    
    func fetchUserData() {
        guard let user = authWebRepository.user else { return }
        state = .loading
        userWebRepository.getUserData(id: user.uid)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished: break
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }, receiveValue: {[weak self] data in
                guard let self, let data else { return }
                self.user = data
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
