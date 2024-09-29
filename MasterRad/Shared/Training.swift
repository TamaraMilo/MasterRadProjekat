//
//  Training.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
struct Training: Identifiable, Hashable, Decodable {
    var id: String
    var name: String
    var date: String
    var time: String
    var trainer: String
    var description: String
    var participants: [UserData]
    
    public static func == (lhs: Training, rhs: Training) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(id: String, name: String, date: String, time: String, trainer: String, description: String, participants: [UserData]) {
        self.id = id
        self.name = name
        self.date = date
        self.time = time
        self.trainer = trainer
        self.description = description
        self.participants = participants
    }
    
    init() {
        id = ""
        name = ""
        date = ""
        time = ""
        trainer = ""
        description = ""
        participants = []
    }
}

struct TrainingW: Identifiable, Hashable, Decodable {
    var id: String
    var name: String
    var date: String
    var time: String
    var trainer: String
    var description: String
    
    public static func == (lhs: TrainingW, rhs: TrainingW) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(id: String, name: String, date: String, time: String, trainer: String, description: String) {
        self.id = id
        self.name = name
        self.date = date
        self.time = time
        self.trainer = trainer
        self.description = description
    }
    
    init() {
        id = ""
        name = ""
        date = ""
        time = ""
        trainer = ""
        description = ""
    }
}

