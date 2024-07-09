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
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<[Person], Error>) in
            switch result {
            case .success(let people):
                completion(people)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func post(person: Person, completion: @escaping (Result<Person, Error>) -> ()) {
        guard let url = URL(string: API_URLs.api()) else { return }
        
        do {
            let jsonData = try JSONEncoder().encode(person)
            NetworkManager.shared.request(url, method: .POST, body: jsonData) { (result: Result<Person, Error>) in
                switch result {
                case .success(let savedPerson):
                    completion(.success(savedPerson))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}

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
