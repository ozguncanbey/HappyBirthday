//
//  ListCell.swift
//  HappyBirthday
//
//  Created by Özgün Can Beydili on 4.07.2024.
//

import SwiftUI

struct ListCell: View {
    let person: Person
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.name ?? "No Name")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading)
                
                HStack {
                    Text(person.birthday ?? "No Date")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.leading)
                    
                    Text("turns \(person.calculateTurnsAge())")
                        .font(.system(size: 14, weight: .medium))
                        .padding(10)
                }
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text(person.calculateLeftDays() ?? "0")
                    .font(.system(size: 16, weight: .bold))
                
                Text("Days")
                    .font(.system(size: 16, weight: .medium))
                    .padding(10)
            }
            .padding()
        }
    }
}

#Preview {
    ListCell(person: .dummy)
}
