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
    
    private var rootEventTracker: RootEventTracker
    private var cancelSet: Set<AnyCancellable> = []
    private let defaults: UserDefaults = UserDefaults.standard
    
    @Published var state: State = .idle
    
    enum State {
        case idle
        case login
        case application
        case register
    }
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
        listenForOpenApplication()
        listenForOpenLogin()
    }
}

extension RootViewModel {
    private func listenForOpenApplication() {
        rootEventTracker.openApplicationSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                self.storeUser()
            }
            .store(in: &cancelSet)
    }
    
    func storeUser() {
        UserDefaults.standard.set("user", forKey: "user")
        self.state = .application
    }
    
    private func listenForOpenLogin() {
        rootEventTracker.openLoginSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                self.removeVendorAndClientFromDefaults()
            }
            .store(in: &cancelSet)
    }
    
    private func removeVendorAndClientFromDefaults() {
        handleClientLogout()
        rootEventTracker.loggedOut = true
        state = .login
    }
    
    private func handleClientLogout() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    func checkAuthentication() {
        if state == .idle {
            state = .login
        }
    }
}
