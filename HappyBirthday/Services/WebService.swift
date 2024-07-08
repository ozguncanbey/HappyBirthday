//
//  WebService.swift
//  HappyBirthDays
//
//  Created by Özgün Can Beydili on 3.07.2024.
//

import Foundation

final class WebService {
    
    func download(completion: @escaping ([Person]?) -> ()) {
        guard let url = URL(string: API_URLs.api()) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
//    func post(person: Person, completion: @escaping ([Person]?) -> ()) {
//        guard let url = URL(string: API_URLs.api()) else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    }
    
    // When error occurs
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    // Decode the news from json and returns data as Article array
    private func handleWithData(_ data: Data) -> [Person]? {
        do {
            let person = try JSONDecoder().decode([Person].self, from: data)
            return person
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
