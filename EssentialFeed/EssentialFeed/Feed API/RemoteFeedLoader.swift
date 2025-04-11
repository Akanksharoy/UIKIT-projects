//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Animesh on 05.04.2025.
//

public final class RemoteFeedLoader: FeedLoader{
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    
    public func load(completion: @escaping (LoadFeedResult) -> Void) {
        client.get(from: url) { [weak self]  result in
            guard let self = self else { return }
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data: data, response: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}



