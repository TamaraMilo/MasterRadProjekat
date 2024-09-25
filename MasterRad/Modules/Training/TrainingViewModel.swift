//
//  TrainingView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import SwiftUI

final class TreningViewModel: ObservableObject {
    
    @Published var state: State = .idle
    @Binding var training: Training
    
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
    }
    
    func addUserToTrain() {
        training.participants.append(user)
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
    
}

extension TreningViewModel {
    enum State {
        case idle
        case loading
        case ready
        case error
    }
}
