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
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case date
        case time
        case trainer
        case description
        case participants
    }
    
    init(from decoder: any Decoder) {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? container.decode(String.self, forKey: .id)) ?? ""
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.date = (try? container.decode(String.self, forKey: .date)) ?? ""
        self.time = (try? container.decode(String.self, forKey: .time)) ?? ""
        self.trainer = (try? container.decode(String.self, forKey: .trainer)) ?? ""
        self.description = (try? container.decode(String.self, forKey: .description)) ?? ""
        self.participants = (try? container.decode([UserData].self, forKey: .participants)) ?? []
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
