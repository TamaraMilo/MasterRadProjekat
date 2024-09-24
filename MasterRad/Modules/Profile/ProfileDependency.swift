//
//  ProfileDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

protocol ProfileInjectable {
    var rootEventTracker: RootEventTracker { get set }
}

final class ProfileDependency: ProfileInjectable {
    var rootEventTracker: RootEventTracker
    
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
    }
}
