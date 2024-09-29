//
//  VendorViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation

final class VendorViewModel: ObservableObject {
    
    private let authWebRepository: AuthRepository
    private let rootEventTracker: RootEventTracker
    
    init(authWebRepository: AuthRepository, rootEventTracker: RootEventTracker) {
        self.authWebRepository = authWebRepository
        self.rootEventTracker = rootEventTracker
    }
    
    func logout() {
        authWebRepository.signOutUser()
        rootEventTracker.openLoginSubject.send()
    }
}
