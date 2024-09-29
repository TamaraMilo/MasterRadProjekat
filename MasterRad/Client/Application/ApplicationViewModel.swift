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
    @Published var days: [Day] = Day.fixtureWeek()
    
    init(rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
    }
    
}

struct Day: Identifiable {
    let id: Int
    var name: String
    var trainings: [Training]
}

extension Day {
    static func fixtureTrainingsForDay() -> [Training] {
        [
            .fixtureTraining1(),
            .fixtureTraining2(),
            .fixtureTraining3(),
            .fixtureTraining4(),
            .fixtureTraining5(),
            .fixtureTraining6(),
            .fixtureTraining7(),
            .fixtureTraining8(),
            .fixtureTraining9(),
            .fixtureTraining10(),
            .fixtureTraining11(),
            .fixtureTraining12(),
            .fixtureTraining13(),
            .fixtureTraining14()
        ]
    }
    
    static func fixtureDay1() -> Day {
        Day(
            id: 1,
            name: "Ponedeljak",
            trainings: fixtureTrainingsForDay()
        )
    }
    static func fixtureDay2() -> Day {
        Day(
            id: 2 ,
            name: "Utorak",
            trainings: fixtureTrainingsForDay()
        )
    }
    static func fixtureDay3() -> Day {
        Day(
            id: 3,
            name: "Sreda",
            trainings: fixtureTrainingsForDay()
        )
    }
    static func fixtureDay4() -> Day {
        Day(
            id: 4,
            name: "Cetvrtak",
            trainings: fixtureTrainingsForDay()
        )
    }
    static func fixtureDay5() -> Day {
        Day(
            id: 5,
            name: "Petak",
            trainings: fixtureTrainingsForDay()
        )
    }
    static func fixtureDay6() -> Day {
        Day(
            id: 6,
            name: "Subota",
            trainings: fixtureTrainingsForDay()
        )
    }
    
    static func fixtureDay7() -> Day {
        Day(
            id: 7,
            name: "Nedelja",
            trainings: fixtureTrainingsForDay()
        )
    }
    
    static func fixtureWeek() -> [Day] {
        [
            fixtureDay1(),
            fixtureDay2(),
            fixtureDay3(),
            fixtureDay4(),
            fixtureDay5(),
            fixtureDay6(),
            fixtureDay7()
        ]
    }
}

extension Training {
    static func fixtureTraining1() -> Training {
        Training(
           id: "1",
           name: "CrossFit",
           date: "31.01.2025",
           time: "09:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    
    static func fixtureTraining2() -> Training {
        Training(
           id: "2",
           name: "FitCom",
           date: "31.01.2025",
           time: "10:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    
    static func fixtureTraining3() -> Training {
        Training(
           id: "3",
           name: "Hiit",
           date: "31.01.2025",
           time: "11:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    
    static func fixtureTraining4() -> Training {
        Training(
           id: "4",
           name: "Olympic weightlift",
           date: "31.01.2025",
           time: "12:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    
    static func fixtureTraining5() -> Training {
        Training(
           id: "5",
           name: "CrossFit",
           date: "31.01.2025",
           time: "13:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    
    static func fixtureTraining6() -> Training {
        Training(
           id: "6",
           name: "FitCom",
           date: "31.01.2025",
           time: "14:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining7() -> Training {
        Training(
           id: "7",
           name: "Hiit",
           date: "31.01.2025",
           time: "15:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining8() -> Training {
        Training(
           id: "8",
           name: "CrossFit",
           date: "31.01.2025",
           time: "16:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining9() -> Training {
        Training(
           id: "9",
           name: "Olympic weightlift",
           date: "31.01.2025",
           time: "17:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining10() -> Training {
        Training(
           id: "10",
           name: "CrossFit",
           date: "31.01.2025",
           time: "18:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining11() -> Training {
        Training(
           id: "11",
           name: "Olympic weightlift",
           date: "31.01.2025",
           time: "19:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining12() -> Training {
        Training(
           id: "12",
           name: "FitCom",
           date: "31.01.2025",
           time: "20:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining13() -> Training {
        Training(
           id: "13",
           name: "Olympic weightlift",
           date: "31.01.2025",
           time: "21:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
    static func fixtureTraining14() -> Training {
        Training(
           id: "14",
           name: "Hiit",
           date: "31.01.2025",
           time: "22:00",
           trainer: "Petar Petrovic",
           description: "1000 i 10000 sklekova",
           participants: UserData.fixtureParticipants()
           )
    }
}

extension UserData {
    static func fixtureParticipants() -> [UserData] {
        [
            fixtureUser(),
            fixtureUser1(),
            fixtureUser2(),
            fixtureUser3(),
            fixtureUser4(),
            fixtureUser()
        ]
    }
    
    static func fixtureUser() -> UserData {
        UserData(id: "0", firstName: "Jovana", lastName: "Petrovic", age: "43", role: "client")
    }
    
    static func fixtureUser1() -> UserData {
        UserData(id: "1", firstName: "Katarina", lastName: "Aleksic", age: "27", role: "client")
    }
    static func fixtureUser2() -> UserData {
        UserData(id: "2", firstName: "Nikola", lastName: "Jovanovic", age: "21", role: "client")
    }
    
    static func fixtureUser3() -> UserData {
        UserData(id: "3", firstName: "Marko", lastName: "Andjelkovic", age: "36", role: "client")
    }
    
    static func fixtureUser4() -> UserData {
        UserData(id: "4", firstName: "Nikola", lastName: "Nikolic", age: "34", role: "client")
    }
    
    static func fixtureUser5() -> UserData {
        UserData(id: "5", firstName: "Aleksandar", lastName: "Jovanovic", age: "30", role: "client")
    }
}
