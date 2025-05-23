//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Akanksha on 18.04.2025.
//

public class URLSessionHTTPClient: HTTPClient {
    
    private struct  UnexpectedValuesRepresentation: Error {}
    private let session:URLSession
    public init(session: URLSession = .shared){
        self.session = session
    }
    
    public func get(from url: URL, completion: @escaping(HTTPClientResult) -> Void){
        session.dataTask(with: url){
            data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data,  let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            }
            else {
               
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
