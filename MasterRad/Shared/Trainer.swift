//
//  Trainer.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

struct Trainer: Identifiable {
    let id: Int
    var fistName: String
    var lastName: String
    var trainings: [Training]
    var biography: String
}
