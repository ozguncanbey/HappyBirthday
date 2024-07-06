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
            VStack {
                Text(person.name ?? "No Name")
                    .font(.system(size: 18, weight: .bold))
                    .padding()
                
                Spacer()
                
                HStack {
                    Text(person.birthday ?? "No Date")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text("turns 21")
                        .padding()
                }
            }
            
            Spacer()
            
            
        }
    }
}

#Preview {
    ListCell(person: .dummy)
}
