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
    @State private var category: Category = .All {
        didSet {
            viewModel.filterPeople(by: category)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Picker("", selection: $category) {
                    ForEach(Category.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                .pickerStyle(.palette)
                .padding(.horizontal)
                .padding(.bottom)
                
                LazyVStack {
                    ForEach(viewModel.peopleSortedByDaysLeft()) { person in
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
        .onAppear {
            viewModel.filterPeople(by: category)
        }
    }
}

#Preview {
    ListScreen()
}
