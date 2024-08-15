//
//  AppSearchViewModel.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 05/08/24.
//

import Foundation

// MARK: - Protocols

protocol AppsSearchViewModelProtocol {
    var apps: [Apps] { get }
    var onDataFetched: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    
    func fetchApps(searchTerm: String)
    func numberOfItemsInSection() -> Int
    func app(at index: Int) -> Apps?
}

// MARK: - ViewModel

class AppsSearchViewModel: AppsSearchViewModelProtocol {
    
    // MARK: - Properties
    
    private let iTunesService: ITunesServiceProtocol
    
    private(set) var apps: [Apps] = []
    var onDataFetched: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    // MARK: - Initializer
    
    init(iTunesService: ITunesServiceProtocol) {
        self.iTunesService = iTunesService
    }
    
    // MARK: - Methods
    
    func fetchApps(searchTerm: String) {
        iTunesService.fetchITunes(searchTerm: searchTerm) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let apps):
                self.apps = apps
                self.onDataFetched?()
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        return apps.count
    }
    
    func app(at index: Int) -> Apps? {
        guard index >= 0 && index < apps.count else { return nil }
        return apps[index]
    }
}
