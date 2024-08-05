//
//  BaseService.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 04/07/24.
//

import Foundation
class BaseService {
    
    func fetchData(from urlString: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
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
