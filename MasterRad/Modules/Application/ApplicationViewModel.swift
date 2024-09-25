//
//  ApplicationViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation

final class ApplicationViewModel: ObservableObject {
    let rootEventTracker: RootEventTracker
    @Published var currentTab: Int = 0
    
    @Published var trainings: [Training] = [
        Training(
            id: 1,
            name: "Training",
            date: "31.01.2025",
            time: "09:00",
            trainer: Trainer(
                id: 1,
                fistName: "Petar",
                lastName: "Petrovic",
                trainings: [],
                biography: "Capcarap"
            ),
            description: "1000 i 10000 sklekova",
            participants: []
        ), Training(
            id: 2,
            name: "Training",
            date: "31.01.2025",
            time: "09:00",
            trainer: Trainer(
                id: 1,
                fistName: "Janko",
                lastName: "Nikolic",
                trainings: [],
                biography: "Capcarap"
            ),
            description: "1000 i 10000 sklekova",
            participants: []
        ), Training(
            id: 3,
            name: "Training",
            date: "31.01.2025",
            time: "09:00",
            trainer: Trainer(
                id: 1,
                fistName: "Stanko",
                lastName: "Jovanovic",
                trainings: [],
                biography: "Capcarap"
            ),
            description: "1000 i 10000 sklekova",
            participants: []
        )]
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
    }
    
}
