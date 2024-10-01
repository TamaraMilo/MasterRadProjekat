//
//  ApplicationViewModel.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import Combine

final class ApplicationViewModel: ObservableObject {
    let rootEventTracker: RootEventTracker
    private var trainingWebRepository: TrainingRepository
    private var disposables = Set<AnyCancellable>()
    
    @Published var currentTab: Int = 0
    @Published var days: [Day] = []
    @Published var trainings: [Training] = []
    
    init(
        rootEventTracker: RootEventTracker,
        trainingWebRepository: TrainingRepository
    ) {
        self.rootEventTracker = rootEventTracker
        self.trainingWebRepository = trainingWebRepository
        fetchTrainings()
    }
    
    func fetchTrainings1() {
        trainingWebRepository.getTrainings()
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished: break
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }, receiveValue: {[weak self] trainings in
                print(trainings)
                self?.trainings = trainings
                
                for training in trainings {
                    let day = self?.mapDay(training: training)
                    //remove duplicates
                    self?.days.append(day!)
//                    self?.days.insert(day!)
                }
            })
            .store(in: &disposables)
    }
    
    func mapDay1(training: Training) -> Day {
        let convertedDate = String.toDate(from: training.date)
        let dateName = convertedDate?.description(with: .current).components(separatedBy: ",").first

        let day = Day(
            id: Int.random(in: 0...1000),
            name: dateName ?? training.date,
            date: convertedDate ?? Date(),
            trainings: []
        )
        
        return day
    }

 }

extension String {
    static func toDate(from stringDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        return formatter.date(from: stringDate)
    }
}

// MARK: ChatGPT
extension ApplicationViewModel {
    func mapDay(training: Training) -> Day {
        // Convert the date string to a Date object
        let convertedDate = String.toDate(from: training.date)
        
        // Extract the name of the day for display (e.g., Monday, Tuesday)
        let dateName = convertedDate?.formatted(.dateTime.weekday(.wide)) ?? training.date
        
        return Day(
            id: Int(convertedDate?.timeIntervalSince1970 ?? 0), // Use timestamp for unique id
            name: dateName,
            date: convertedDate ?? Date(),
            trainings: []
        )
    }
    
    func fetchTrainings() {
        trainingWebRepository.getTrainings()
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished: break
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }, receiveValue: { [weak self] trainings in
                print(trainings)
                self?.trainings = trainings
                
                // Clear the existing days to avoid duplication
                self?.days.removeAll()
                
                for training in trainings {
                    // Convert the date string to Date
                    let day = self?.mapDay(training: training)
                    
                    // Check if the day already exists in the days array
                    if let day = day, let index = self?.days.firstIndex(where: { $0.date == day.date }) {
                        // If the day exists, add the training to the existing day
                        self?.days[index].trainings.append(training)
                    } else {
                        // If the day does not exist, create a new one
                        var newDay = day!
                        newDay.trainings = [training]
                        self?.days.append(newDay)
                    }
                }
            })
            .store(in: &disposables)
    }


}

struct Day: Identifiable, Hashable {
    var id: Int
    var name: String
    var date: Date = Date()
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
//            date: "29.09.2024.",
            trainings: fixtureTrainingsForDay()
        )
    }
    static func fixtureDay2() -> Day {
        Day(
            id: 2 ,
            name: "Utorak",
//            date: "30.09.2024.",
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
           date: "29.09.2024",
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
           date: "30.09.2024",
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
