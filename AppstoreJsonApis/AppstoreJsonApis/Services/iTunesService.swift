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
protocol ITunesGameServiceProtocol {
    func fetchGames(from urlString: String,completion: @escaping (Result<AppsGroup, Error>) -> Void)
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
//"https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json
//https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json
//https://rss.applemarketingtools.com/api/v2/us/podcasts/top/10/podcasts.json
class ITunesGameService: BaseService, ITunesGameServiceProtocol {
    func fetchGames(from urlString: String, completion: @escaping (Result<AppsGroup, Error>) -> Void) {
        // Create a URL from the input string
        guard let url = URL(string: urlString) else {
            completion(.failure(ServiceError.invalidURL))  // Handle invalid URL error
            return
        }
        
        // Fetch data from the URL
        fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let appGroup = try JSONDecoder().decode(AppsGroup.self, from: data)
                    print(appGroup.feed.results.forEach({ print($0.name) }))
                    completion(.success(appGroup))
                } catch {
                    print("JSON decoding failed")
                    completion(.failure(ServiceError.decodingFailed(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
protocol SocialAppProtocol {
    func fetchSocialApps(completion: @escaping (Result<SocialApp, Error>) -> Void)
}
class SocialAppService: BaseService, SocialAppProtocol {
    func fetchSocialApps(completion: @escaping (Result<SocialApp, Error>) -> Void) {
        var urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let socialApp = try JSONDecoder().decode(SocialApp.self, from: data)
                    completion(.success(socialApp))
                } catch {
                    print("JSON decoding failed")
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
