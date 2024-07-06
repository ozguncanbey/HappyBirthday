//
//  ListViewModel.swift
//  HappyBirthday
//
//  Created by Özgün Can Beydili on 4.07.2024.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    private let service = WebService()
    @Published var people: [Person] = []
    
    init() { getPeople() }
    
    func getPeople() {
        service.download { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.people = result
            }
        }
    }
    
    /// sorts list as left days to birthday
    func peopleSortedByDaysLeft() -> [Person] {
        return people.sorted(by: { person1, person2 in
            guard let daysLeft1 = person1.calculateLeftDays(),
                  let daysLeft2 = person2.calculateLeftDays() else {
                return false
            }
            return Int(daysLeft1)! < Int(daysLeft2)!
        })
    }
}
