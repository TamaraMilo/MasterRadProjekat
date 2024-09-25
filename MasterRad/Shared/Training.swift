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
    
    init(id: Int, name: String, date: String, time: String, trainer: Trainer, description: String, participants: [UserData]) {
        self.id = id
        self.name = name
        self.date = date
        self.time = time
        self.trainer = trainer
        self.description = description
        self.participants = participants
    }
    
    init() {
        id = 0
        name = ""
        date = ""
        time = ""
        trainer = Trainer(
            id: 0,
            fistName: "",
            lastName: "",
            trainings: [],
            biography: ""
        )
        description = ""
        participants = []
    }
}
