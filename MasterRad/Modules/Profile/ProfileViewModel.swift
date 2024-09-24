//
//  ProfileViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

final class ProfileViewModel: ObservableObject {
    private var rootEventTracker: RootEventTracker
    @Published var user: UserData = UserData()
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
    }
    
    func logout() {
        rootEventTracker.openLoginSubject.send()
        // TODO: Pop child
    }
}
