//
//  VendorDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation

protocol VendorInjectable {
    var sharedData: VendorSharedData { get set }
}

final class VendorDependency: VendorInjectable {
    var sharedData: VendorSharedData
    
    init(sharedData: VendorSharedData) {
        self.sharedData = sharedData
    }
    
}
