//
//  ListScreen.swift
//  HappyBirthday
//
//  Created by Özgün Can Beydili on 4.07.2024.
//

import SwiftUI

struct ListScreen: View {
    @StateObject var viewModel = ListViewModel()
    @State private var navigateToAddNewPersonScreen = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.people) { person in
                        ListCell(person: person)
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Happy Birthday")
            .toolbar {
                ToolbarItem {
                    Button("Add", systemImage: "plus.circle.fill", role: .destructive) {
                        navigateToAddNewPersonScreen = true
                    }
                }
            }
            .padding(.top)
            .navigationDestination(isPresented: $navigateToAddNewPersonScreen) {
                AddNewPersonScreen()
            }
        }
    }
}

#Preview {
    ListScreen()
}
