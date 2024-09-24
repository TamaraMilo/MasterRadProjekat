//
//  RootEventTracker.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import Combine

class RootEventTracker: ObservableObject {
    let openLoginSubject = PassthroughSubject<Void, Never>()
    let openApplicationSubject = PassthroughSubject<Void, Never>()
    var loggedOut: Bool = false
}
