//
//  NetworkManager.swift
//
//
//  Created by Özgün Can Beydili
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    /// Generic download function with URLSession
    func request<T: Decodable>(_ url: URL, method: HttpMethod, body: Data? = nil, completion: @escaping (Result<T, Error>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}

enum HttpMethod: String {
    case GET
    case POST
}
