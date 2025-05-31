//
//  AppsHeaderHorizontalViewModel.swift
//  AppstoreJsonApis
//
//  Created by Akanksha on 24.05.2025.
//
protocol AppsHeaderHorizontalViewModelProtocol {
    var socialApps: [SocialApp] { get }
    var onSocialAppsUpdated: (() -> Void)? { get set }
    func fetchSocialApps()
}

class AppsHeaderHorizontalViewModel: AppsHeaderHorizontalViewModelProtocol {
    private let service: ITunesGameServiceProtocol
    var socialApps: [SocialApp] = []
    var onSocialAppsUpdated: (() -> Void)?

    init(service: ITunesGameServiceProtocol) {
        self.service = service
    }

    func fetchSocialApps() {
        service.fetchSocialApps { [weak self] result in
            switch result {
            case .success(let apps):
                self?.socialApps = apps
                self?.onSocialAppsUpdated?()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

