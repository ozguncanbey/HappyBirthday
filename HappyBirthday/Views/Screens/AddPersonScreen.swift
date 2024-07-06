//
//  AddPersonScreen.swift
//  HappyBirthday
//
//  Created by Özgün Can Beydili on 4.07.2024.
//

import SwiftUI

struct AddPersonScreen: View {
    
    @State private var name = ""
    @State private var date: Date = .init()
    
    private var isAddButtonDisable: Bool {
        name.isEmpty
    }
    var body: some View {
        NavigationStack {
            List {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Date") {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
            }
            .navigationTitle("Add New Person")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        
                    }
                    .disabled(isAddButtonDisable)
                }
            }
        }
    }
}

#Preview {
    AddPersonScreen()
}
