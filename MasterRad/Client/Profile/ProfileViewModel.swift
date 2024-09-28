//
//  ProfileViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

final class ProfileViewModel: ObservableObject {
    private var rootEventTracker: RootEventTracker
    private var oldUserData: UserData = UserData()
    private var userWebRepository: UserRepository
    private var authWebRepository: AuthRepository
    
    @Published var user: UserData = UserData()
    @Published private(set) var state: State = .idle
    @Published var newPassword: String = ""
    @Published var repeatNewPassword: String = ""
    @Published var editMode: Bool = false
    
    init(userWebRepository: UserRepository, authWebRepository: AuthRepository,rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
    }
    
    func logout() {
        authWebRepository.signOutUser()
        // TODO: Pop child
        rootEventTracker.openLoginSubject.send()

    }
    
    
    @MainActor
    func fetchUserData() async {
        guard let user = authWebRepository.user else { return }
        state = .loading
        let data =  await userWebRepository.getUserData(id: user.uid)
        if let data  {
            self.user = data
            oldUserData = data
            state = .ready
        }
    }
    
    func updateUserData() {
        userWebRepository.updateUserData(userData: user)
    }
    
    func changePassword() {
        authWebRepository.changePassword(newPassword: newPassword)
    }
    
    var isUserDataEntered: Bool {
        !user.age.isEmpty &&
        !user.firstName.isEmpty &&
        !user.lastName.isEmpty
    }
    
    var arePasswordsEntered: Bool {
        !newPassword.isEmpty &&
        !repeatNewPassword.isEmpty &&
        newPassword == repeatNewPassword
    }
    
    func processEditMode() {
        if editMode {
            user = oldUserData
            editMode = false
        } else {
            editMode = true
        }
    }
}

extension ProfileViewModel {
    enum State {
        case idle
        case loading
        case ready
        case error
    }
}
