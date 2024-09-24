//
//  ApplicationDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation


protocol ApplicationInjectable {
    var rootEventTracker: RootEventTracker { get set }
}

final class ApplicationDependency: ApplicationInjectable {
    var rootEventTracker: RootEventTracker
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
    }
}
