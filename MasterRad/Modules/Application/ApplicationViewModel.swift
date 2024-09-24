//
//  ApplicationViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation

final class ApplicationViewModel: ObservableObject {
    let rootEventTracker: RootEventTracker
    
    @Published var trainings: [Training] = [Training(
        id: 1,
        name: "Training",
        date: "09:00",
        trainer: Trainer(
            id: 1,
            fistName: "Petar",
            lastName: "Petrovic",
            trainings: [],
            biography: ""
        )
    ), Training(
        id: 1,
        name: "Training",
        date: "09:00",
        trainer: Trainer(
            id: 1,
            fistName: "Petar",
            lastName: "Petrovic",
            trainings: [],
            biography: ""
        )
    ), Training(
        id: 1,
        name: "Training",
        date: "09:00",
        trainer: Trainer(
            id: 1,
            fistName: "Petar",
            lastName: "Petrovic",
            trainings: [],
            biography: ""
        )
    )]
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
    }

}
