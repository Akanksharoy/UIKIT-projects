//
//  AppSearchViewModel.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 05/08/24.
//

import Foundation

class AppsSearchViewModel {
    
    private let iTunesService: ITunesServiceProtocol
    
    var apps: [Apps] = []
    var onDataFetched: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(iTunesService: ITunesServiceProtocol = ITunesService()) {
        self.iTunesService = iTunesService
    }
    
    func fetchApps(searchTerm: String) {
        iTunesService.fetchITunes(searchTerm: searchTerm) { [weak self] result in
            switch result {
            case .success(let apps):
                self?.apps = apps
                self?.onDataFetched?()
            case .failure(let error):
                self?.onError?(error)
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
