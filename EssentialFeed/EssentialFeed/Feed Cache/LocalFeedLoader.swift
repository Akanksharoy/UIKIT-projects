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
    
    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] error in
            guard let self = self else { return }
            
            
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.store.insert(feed.toLocal(), timestamp: self.currentDate()) { [weak self] error in
                    guard self != nil else { return }
                    completion(error)
                }
            }
        }
    }

}
private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    }
}
