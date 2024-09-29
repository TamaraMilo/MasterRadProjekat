//
//  LoginDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation

protocol LoginInjectable {
    var rootEventTracker: RootEventTracker { get set }
    var webRepository: AuthRepository { get }
    var userWebRepository: UserRepository { get }
}

final class LoginDependency: LoginInjectable {
    var rootEventTracker: RootEventTracker
    var webRepository: AuthRepository
    var userWebRepository: UserRepository
    
    init(
        webRepository: AuthRepository,
        rootEventTracker: RootEventTracker,
        userWebRepository: UserRepository
    ) {
        self.rootEventTracker = rootEventTracker
        self.webRepository = webRepository
        self.userWebRepository = userWebRepository
    }
}
