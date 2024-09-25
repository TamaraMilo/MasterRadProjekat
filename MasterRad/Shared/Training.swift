//
//  Training.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
struct Training: Identifiable, Hashable {
    let id: Int
    var name: String
    var date: String
    var time: String
    var trainer: Trainer
    var description: String
    var participants: [UserData]
    
    public static func == (lhs: Training, rhs: Training) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
