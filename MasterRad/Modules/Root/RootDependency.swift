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
}

final class RootDependency: RootInjectable {
    var rootEventTracker: RootEventTracker
    var sharedData: SharedData
    var authWebRepository: AuthRepository

    init(
        authWebRepository: AuthRepository,
        rootEventTracker: RootEventTracker,
        sharedData: SharedData
    ) {
        self.rootEventTracker = rootEventTracker
        self.sharedData = sharedData
        self.authWebRepository = authWebRepository
    }
}


