//
//  VendorDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation

protocol VendorInjectable {
    var sharedData: VendorSharedData { get set }
    var rootEventTracker: RootEventTracker { get }
    var authWebRepository: AuthRepository { get }
    
}

final class VendorDependency: VendorInjectable {
    var sharedData: VendorSharedData
    var rootEventTracker: RootEventTracker
    var authWebRepository: AuthRepository
    
    init(
        sharedData: VendorSharedData,
        rootEventTracker: RootEventTracker,
        authWebRepository: AuthRepository
    ) {
        self.sharedData = sharedData
        self.rootEventTracker = rootEventTracker
        self.authWebRepository = authWebRepository
    }
    
}
