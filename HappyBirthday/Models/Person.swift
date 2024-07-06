//
//  Person.swift
//  HappyBirthDays
//
//  Created by Özgün Can Beydili on 3.07.2024.
//

import Foundation

struct Person: Codable {
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
    
    func calculateTurnsAge() -> String {
        
        return ""
    }
    
    func calculateLeftDays() -> String {
        return ""
    }
}

extension Person {
    static var dummy: Person {
        .init(id: 0, name: "Özgün Can Beydili", birthday: "02/10/2002")
    }
}
