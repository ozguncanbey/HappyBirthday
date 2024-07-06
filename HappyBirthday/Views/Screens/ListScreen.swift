//
//  ListScreen.swift
//  HappyBirthday
//
//  Created by Özgün Can Beydili on 4.07.2024.
//

import SwiftUI

struct ListScreen: View {
    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
        NavigationStack {
            LazyVStack {
                ForEach(viewModel.people.indices, id: \.self) { index in
                    
                }
            }
        }
    }
}

#Preview {
    ListScreen()
}
