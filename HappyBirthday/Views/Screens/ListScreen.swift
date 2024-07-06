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
                    ForEach(viewModel.people.indices, id: \.self) { index in
                        ListCell(person: viewModel.people[index])
                        if index != viewModel.people.indices.last {
                            Divider()
                        }
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
