//
//  iTunesService.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 04/07/24.
//
import Foundation

protocol ITunesServiceProtocol {
    func fetchITunes(completion: @escaping (Result<[Apps], Error>) -> Void)
}

class iTunesService: BaseService, ITunesServiceProtocol {

    func fetchITunes(completion: @escaping (Result<[Apps], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

