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
    
    func post(person: Person, completion: @escaping (Result<Person, Error>) -> ()) {
        guard let url = URL(string: "http://localhost:5166/BirthDays") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(person)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let error = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey : "Unexpected response"])
                completion(.failure(error))
                return
            }
            
            do {
                let savedPerson = try JSONDecoder().decode(Person.self, from: data)
                completion(.success(savedPerson))
            } catch {
                completion(.failure(error))
            }
        }.resume()
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
}
