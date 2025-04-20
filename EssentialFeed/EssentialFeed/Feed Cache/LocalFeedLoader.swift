//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Akanksha on 19.04.2025.
//

public final class LocalFeedLoader {
    private let store: FeedStore
        private let currentDate: () -> Date
        
        public typealias SaveResult = Error?
        
        public init(store: FeedStore, currentDate: @escaping () -> Date) {
            self.store = store
            self.currentDate = currentDate
        }
    
    public func save(_ items: [FeedItem], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] error in
            guard let self = self else { return }
            
            
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.store.insert(items.toLocal(), timestamp: self.currentDate()) { [weak self] error in
                    guard self != nil else { return }
                    completion(error)
                }
            }
        }
    }

}
private extension Array where Element == FeedItem {
    func toLocal() -> [LocalFeedItem] {
        return map { LocalFeedItem(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.imageURL)}
    }
}

public struct LocalFeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL

    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
