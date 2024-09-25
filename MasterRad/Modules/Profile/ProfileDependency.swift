//
//  ProfileDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

protocol ProfileInjectable {
    var rootEventTracker: RootEventTracker { get set }
    var userWebRepository: UserRepository { get }
    var authWebRepository: AuthRepository { get }
}

final class ProfileDependency: ProfileInjectable {
    var rootEventTracker: RootEventTracker
    var userWebRepository: UserRepository
    var authWebRepository:  AuthRepository
    
    init(
        userWebRepository: UserRepository,
        authWebRepository: AuthRepository,
        rootEventTracker: RootEventTracker
    ) {
        self.rootEventTracker = rootEventTracker
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
    }
}
