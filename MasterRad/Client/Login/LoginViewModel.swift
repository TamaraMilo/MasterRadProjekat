//
//  LoginViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
   
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    private var webRepository: AuthRepository
    private var rootEventTracker: RootEventTracker
    private var userWebRepository: UserRepository

    
    var alertText: String = ""
    
    init(
        webRepository: AuthRepository,
        rootEventTracker: RootEventTracker,
        userWebRepository: UserRepository
    ) {
        self.webRepository = webRepository
        self.rootEventTracker = rootEventTracker
        self.userWebRepository = userWebRepository
    }
}

extension LoginViewModel {
    func signIn() {
        guard checkCredentialsInput() else { return }
        webRepository.signIn(password: password, email: email)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self else { return }
                switch result {
                case .finished: break
                case .failure(let error):
                    alertText = error.localizedDescription
                    showAlert = true
                }
            }, receiveValue: { [weak self] user in
                guard let self else { return }
                checkAuthentication(id: user.uid)
                print(user.uid)
            })
            .store(in: &disposables)
    }
    
    func openRegisterView() {
        rootEventTracker.openRegisterSubject.send(())
    }
    
}

private extension LoginViewModel {
    func checkCredentialsInput() -> Bool {
        alertText = !credentialsEntered ? "Email and Password can't be empty!" : ""
        showAlert = !credentialsEntered
        return credentialsEntered
    }
    
    func checkAuthentication(id: String) {
        userWebRepository.getUserData(id: id)
            .sink(receiveCompletion: {result in
                switch result {
                case .finished: break
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }, receiveValue: {[weak self] data in
                guard let self, let data else { return }
                print(data)
                if data.role == "client" {
                    rootEventTracker.openApplicationSubject.send()
                } else {
                    rootEventTracker.openVendorSubject.send()
                    print("vendor")
                }
            })
            .store(in: &disposables)
    }
    

}

extension LoginViewModel {
    var credentialsEntered: Bool {
        !email.isEmpty && !password.isEmpty
    }
}
