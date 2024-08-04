//
//  BaseService.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 04/07/24.
//

import Foundation
class BaseService {
    
    func fetchData(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 204, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
