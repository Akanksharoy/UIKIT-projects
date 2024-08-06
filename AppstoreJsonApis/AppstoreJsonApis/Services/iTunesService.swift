//
//  iTunesService.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 04/07/24.
//
import Foundation

protocol ITunesServiceProtocol {
    func fetchITunes(searchTerm: String, completion: @escaping (Result<[Apps], Error>) -> Void)
}

class ITunesService: BaseService, ITunesServiceProtocol {

    func fetchITunes(searchTerm: String, completion: @escaping (Result<[Apps], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(ServiceError.decodingFailed(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum ServiceError: Error {
    case invalidURL
    case decodingFailed(Error)
}
