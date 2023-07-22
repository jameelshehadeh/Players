//
//  NetworkService.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import Foundation

enum NetworkingErrors : Error {
    case invalidURL
    case badRequest
    case invalidData
    case failToDecodeJSON
    
}

protocol Servicing {
    
    func request<T: Codable>(endPoint: Endpoint,method : HTTPMethod,body: Data? ,completion: @escaping (Result<T?,Error>)->())
    
}

class NetworkService : Servicing {
    
    func request<T: Codable>(endPoint: Endpoint, method: HTTPMethod = .post, body: Data? = nil, completion: @escaping (Result<T?, Error>) -> ()) {
        
        guard let url = URL(string: endPoint.url) else {
            completion(.failure(NetworkingErrors.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        NSLog("⬜️⬜️ \(url) API call started")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data , response, error in
            guard let data = data else {
                if let error {
                    NSLog("🟥🟥 \(url) API call failed(\(error.localizedDescription)")
                    completion(.failure(error))
                }
                else {
                    completion(.failure(NetworkingErrors.invalidData))
                }
                return
            }

            guard let decodedData = self.decodeJSON(type: T.self,from: data) else {
                NSLog("🟧🟧 \(url) Object decoding failed")
                completion(.failure(NetworkingErrors.failToDecodeJSON))
                return
            }
            completion(.success(decodedData))
            NSLog("🟦🟦 \(url) API response recevied")
                
        }
        
        task.resume()
    }
    
    func decodeJSON<T: Codable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print(error)
            return nil
        }
    }
    
}
