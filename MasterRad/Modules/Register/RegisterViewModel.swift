//
//  RegisterViewModel.swift
//  MasterRad
//
//  Created by Tamara Milovanovic on 24.9.24..
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    
    private var authWebRepository: AuthRepository
    private var userWebRepository: UserRepository
    private var rootEventTracker: RootEventTracker
    private var disposables = Set<AnyCancellable>()
    
    var alertText: String = ""

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatedPassword: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var age: String = ""
    @Published var showAlert: Bool = false

    
    init(
        authWebRepository: AuthRepository,
        userWebRepository: UserRepository,
        rootEventTracker: RootEventTracker
    ) {
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
        self.rootEventTracker = rootEventTracker
    }
}

extension RegisterViewModel {
    func signUp() {
        guard checkCredentialsInput() else { return }
        authWebRepository.signUp(with: email, password: password)
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
                createUser(accountId: user.uid)
                openApplicationView()
            })
            .store(in: &disposables)
    }

    func openLoginView() {
        rootEventTracker.openLoginSubject.send()
    }
}

private extension RegisterViewModel {
    
    func openApplicationView() {
        rootEventTracker.openApplicationSubject.send()
    }
    
    func createUser(accountId: String) {
        userWebRepository.createUser(id: accountId, name: name, surname: surname, age: age)
    }
    
    
    func checkCredentialsInput() -> Bool {
        alertText = !credentialsEntered ? "Email, password and repeated can't be empty! Password and repeated password must match! Information for user must be filled!" : ""
        showAlert = !credentialsEntered
        return credentialsEntered
    }
}


private extension RegisterViewModel {
    var credentialsEntered: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        !repeatedPassword.isEmpty &&
        password == repeatedPassword &&
        !name.isEmpty &&
        !surname.isEmpty &&
        !age.isEmpty
    }
}
