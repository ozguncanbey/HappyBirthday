//
//  Person.swift
//  HappyBirthDays
//
//  Created by Özgün Can Beydili on 3.07.2024.
//

import Foundation

struct Person: Codable, Identifiable {
    let id: Int?
    let name: String?
    let birthday: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "fullname"
        case birthday
    }
}

extension Person {
    
    /// converts date to required format
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    /// converts string to date
    func dateOfBirth() -> Date? {
        guard let birthday = birthday else { return nil }
        return dateFormatter.date(from: birthday)
    }
    
    /// calculates the age
    func calculateTurnsAge() -> Int {
        let calendar = Calendar.current
        let now = Date()
        
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth()!, to: now)
        let age = ageComponents.year ?? 0
        
        return age + 1
    }
    
    /// calculates how many days between today and birthday
    func calculateLeftDays() -> String? {
        guard let dateOfBirth = dateOfBirth() else { return nil }
        
        let calendar = Calendar.current
        let now = Date()
        
        var components = calendar.dateComponents([.month, .day], from: dateOfBirth)
        components.year = calendar.component(.year, from: now)
        
        // Calculate is birth date this year or not
        guard let birthdayThisYear = calendar.date(from: components) else {
            return nil
        }
        
        if now >= birthdayThisYear {
            components.year! += 1
        }
        
        guard let nextBirthday = calendar.date(from: components) else {
            return nil
        }
        
        let daysLeft = calendar.dateComponents([.day], from: now, to: nextBirthday).day
        
        return daysLeft?.codingKey.stringValue
    }
}

extension Person {
    static var dummy: Person {
        .init(id: 0, name: "Özgün Can Beydili", birthday: "02/10/2002")
    }
}
