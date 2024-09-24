//
//  Coordinable.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import SwiftUI

public protocol Coordinable {
    associatedtype Data: ObservableObject
    
    ///A default view for each coordinator
    var view: AnyView { get }

    /// A observable object
    ///
    /// It is composed of variables and methods shared between super module views.
    var observedData: Data { get }
}

public extension Coordinable where Data == DefaultData {
    var observedData: Data {
        DefaultData()
    }
}

public class DefaultData: ObservableObject {}
