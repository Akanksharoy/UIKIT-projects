//
//  AppsPageViewModel.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 21/08/24.
//

import Foundation

// MARK: - Protocol for AppsPageViewModel
protocol AppsPageViewModelProtocol {
    var onGamesFetched: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var games: [AppsGroup] { get }  // Updated to non-optional
    
    func fetchGames()
    func fetchSocialApps()
    var onSocialAppsFetched: (() -> Void)? { get set }
    var socialApps: [SocialApp] {get}
}
// MARK: - ViewModel
class AppsPageViewModel: AppsPageViewModelProtocol {
    var onSocialAppsFetched: (() -> Void)?
    
    private(set) var games: [AppsGroup] = []
    private(set) var socialApps:[SocialApp] = []
    
    // Closure for updating the view
    var onGamesFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // Holds the fetched games
    
    // Service instance
    private let service: ITunesGameServiceProtocol
    
    // Initialization
    init(service: ITunesGameServiceProtocol = ITunesGameService()) {
        self.service = service
    }
    let urls = [
        "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json",
        "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json",
        "https://rss.applemarketingtools.com/api/v2/us/podcasts/top/10/podcasts.json"
    ]
    
    // Fetch games function
    func fetchGames() {
        let dispatchGroup = DispatchGroup()
        var fetchedGames = [AppsGroup]()
        for url in urls {
            dispatchGroup.enter()
            service.fetchGames(from: url) { [weak self] result in
                
                switch result {
                case .success(let appsGroup):
                    fetchedGames.append(appsGroup)
                    
                default: 
                    break
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main){ [weak self] in
            self?.games = fetchedGames
            self?.onGamesFetched?()
        }
    }
    func fetchSocialApps(){
        service.fetchSocialApps(){ [weak self] result in
            switch result {
            case .success(let socialApps):
                
                self?.socialApps = socialApps
                self?.onSocialAppsFetched?()
            case .failure(let error):
                break
            }
            
        }
    }
}
