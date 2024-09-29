//
//  RootViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import SwiftUI
import Combine

final class RootViewModel: ObservableObject {
    
    @Published var state: State = .vendor
    
    private var rootEventTracker: RootEventTracker
    private var cancelSet: Set<AnyCancellable> = []
    private let defaults: UserDefaults = UserDefaults.standard
    private let authWebRepository: AuthRepository
    
    
    enum State {
        case idle
        case login
        case application
        case register
        case vendor
    }
    
    init(authWebRepository: AuthRepository, rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
        self.authWebRepository = authWebRepository
        self.listenForOpenApplication()
        self.listenForOpenLogin()
        self.listenForOpenRegister()
    }
}

extension RootViewModel {
    private func listenForOpenApplication() {
        rootEventTracker.openApplicationSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                state = .application
            }
            .store(in: &cancelSet)
    }
    
    private func listenForOpenRegister(){
        rootEventTracker.openRegisterSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                state = .register
            }
            .store(in: &cancelSet)
    }
    
    private func listenForOpenLogin() {
        rootEventTracker.openLoginSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                authWebRepository.signOutUser()
                state = .login
            }
            .store(in: &cancelSet)
    }
    
    private func handleClientLogout() {
        authWebRepository.signOutUser()
    }
    
    func checkAuthentication() {
        state = !authWebRepository.isUserLoggedIn ? .login : .application
    }
}
