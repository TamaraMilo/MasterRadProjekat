//
//  RootDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import Combine

protocol RootInjectable {
    var rootEventTracker: RootEventTracker { get set }
    var sharedData: SharedData { get set }
    var authWebRepository: AuthRepository { get }
    var userWebRepository: UserRepository { get }
}

final class RootDependency: RootInjectable {
    var rootEventTracker: RootEventTracker
    var sharedData: SharedData
    var authWebRepository: AuthRepository
    var userWebRepository: UserRepository

    init(
        authWebRepository: AuthRepository,
        rootEventTracker: RootEventTracker,
        sharedData: SharedData,
        userWebRepository: UserRepository
    ) {
        self.rootEventTracker = rootEventTracker
        self.sharedData = sharedData
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
    }
}


