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
    
    @Published var state: State = .idle
    
    private var rootEventTracker: RootEventTracker
    private var cancelSet: Set<AnyCancellable> = []
    private let defaults: UserDefaults = UserDefaults.standard
    private let authWebRepository: AuthRepository
    private let userWebRepository: UserRepository
    
    
    enum State {
        case idle
        case login
        case application
        case register
        case vendor
    }
    
    init(authWebRepository: AuthRepository,userWebRepository: UserRepository, rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
        self.listenForOpenApplication()
        self.listenForOpenLogin()
        self.listenForOpenRegister()
        self.listenForOpenVendor()
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
    
    private func listenForOpenVendor() {
        rootEventTracker.openVendorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                state = .vendor
            }
            .store(in: &cancelSet)
    }
    
    private func handleClientLogout() {
        authWebRepository.signOutUser()
    }
    
    func checkAuthentication() {
        if authWebRepository.isUserLoggedIn, let userId = authWebRepository.user?.uid {
            userWebRepository.getUserData(id: userId)
                .sink(receiveCompletion: {result in
                    switch result {
                    case .finished: break
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                    
                }, receiveValue: {[weak self] data in
                    guard let self, let data else { return }
                    state = data.role == "client" ? .application : .vendor
                })
                .store(in: &cancelSet)
        } else {
            state = .login
        }
    }
}
