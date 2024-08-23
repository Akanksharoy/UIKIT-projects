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
    var games: AppsGroup? { get }
    
    func fetchGames()
}
// MARK: - ViewModel
class AppsPageViewModel: AppsPageViewModelProtocol {
    // Closure for updating the view
    var onGamesFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // Holds the fetched games
    private(set) var games: AppsGroup?
    
    // Service instance
    private let service: ITunesGameServiceProtocol
    
    // Initialization
    init(service: ITunesGameServiceProtocol = ITunesGameService()) {
        self.service = service
    }
    
    // Fetch games function
    func fetchGames() {
        service.fetchGames { [weak self] result in
            switch result {
            case .success(let appsGroup):
                self?.games = appsGroup
                self?.onGamesFetched?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
