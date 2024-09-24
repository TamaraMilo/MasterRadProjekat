//
//  RegisterDependency.swift
//  MasterRad
//
//  Created by Tamara Milovanovic on 24.9.24..
//

import Foundation

protocol RegisterInjectable {
    var rootEventTracker: RootEventTracker { get set }
    var authWebRepository: AuthRepository { get }
    var userWebRepository: UserRepository { get }
}

final class RegisterDependency: RegisterInjectable {
    
    var rootEventTracker: RootEventTracker
    var authWebRepository: AuthRepository
    var userWebRepository: UserRepository
    
    init(
        rootEventTracker: RootEventTracker,
        authWebRepository: AuthRepository,
        userWebRepository: UserRepository
    ) {
        self.rootEventTracker = rootEventTracker
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
    }
    
}
