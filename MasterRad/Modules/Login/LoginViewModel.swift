//
//  LoginViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation

final class LoginViewModel: ObservableObject {
    private var rootEventTracker: RootEventTracker
    private var webRepository: AuthRepository
    
    //@Published var user: User = User()
    
    init(webRepository: AuthRepository, rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
        self.webRepository = webRepository
    }
    
    func signIn() {
       // UserDefaults.standard.set(user.id, forKey: "userId")
        // UserDefaults.standard.set(user.firstName, forKey: "userName")
        rootEventTracker.loggedOut = false
        openApplication()
    }
    
    private func openApplication() {
         rootEventTracker.openApplicationSubject.send(())
     }
}
