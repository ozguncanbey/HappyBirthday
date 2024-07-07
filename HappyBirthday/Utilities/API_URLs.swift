//
//  API_URLs.swift
//  HappyBirthDays
//
//  Created by Özgün Can Beydili on 28.06.2024.
//

import Foundation

enum API_URLs {
    
    static private let endpoint = "BirthDays"
    static private let baseURL = "http://localhost:5166/"
    
    static func api() -> String {
        "\(baseURL)\(endpoint)"
    }
    
    static func apiAsCategory(as category: String) -> String {
        "\(baseURL)\(endpoint)/\(category)"
    }
}
