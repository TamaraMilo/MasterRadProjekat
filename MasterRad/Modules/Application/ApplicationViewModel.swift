//
//  ApplicationViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation

final class ApplicationViewModel: ObservableObject {
    let rootEventTracker: RootEventTracker
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
    }

}
