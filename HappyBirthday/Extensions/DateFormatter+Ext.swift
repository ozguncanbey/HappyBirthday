//
//  Date+Ext.swift
//  HappyBirthday
//
//  Created by Özgün Can Beydili on 9.07.2024.
//

import Foundation

extension DateFormatter {
    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}
