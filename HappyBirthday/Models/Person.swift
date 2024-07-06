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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        return formatter
    }
    
    func dateOfBirth() -> Date? {
        guard let birthday = birthday else { return nil }
        return dateFormatter.date(from: birthday)
    }
    
    func calculateTurnsAge() -> Int {
        let calendar = Calendar.current
        let now = Date()
        
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth()!, to: now)
        let age = ageComponents.year ?? 0
        
        return age
    }
    
    func calculateLeftDays() -> String? {
        guard let dateOfBirth = dateOfBirth() else { return nil }
        
        let calendar = Calendar.current
        let now = Date()
        
        // Doğum günü bu yıl mı, yoksa gelecek yıl mı hesapla
        var components = calendar.dateComponents([.month, .day], from: dateOfBirth)
        components.year = calendar.component(.year, from: now)
        
        guard let birthdayThisYear = calendar.date(from: components) else {
            return nil
        }
        
        // Doğum günü bu yıl geçtiyse, bir sonraki yıl hesapla
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
