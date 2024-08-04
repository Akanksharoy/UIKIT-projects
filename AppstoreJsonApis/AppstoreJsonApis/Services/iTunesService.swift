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
        fetchData(from: urlString) { result in
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

