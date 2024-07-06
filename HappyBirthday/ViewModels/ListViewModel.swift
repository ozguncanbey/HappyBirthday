//
//  ListViewModel.swift
//  HappyBirthday
//
//  Created by Özgün Can Beydili on 4.07.2024.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    private let service = WebService()
    @Published var people: [Person] = []
    
    init() { getPeople() }
    
    func getPeople() {
        service.download { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.people = result
            }
        }
    }
}
