//
//  ApplicationDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation


protocol ApplicationInjectable {
    var rootEventTracker: RootEventTracker { get set }
    var userWebRepository: UserRepository { get }
    var authWebRepository: AuthRepository { get }
}

final class ApplicationDependency: ApplicationInjectable {
    var rootEventTracker: RootEventTracker
    var userWebRepository: UserRepository
    var authWebRepository: AuthRepository
    
    init(
        rootEventTracker: RootEventTracker,
        userWebRepository: UserRepository,
        authWebRepository: AuthRepository
    ) {
        self.rootEventTracker = rootEventTracker
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
    }
}
