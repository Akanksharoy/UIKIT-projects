//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Akanksha on 06.04.2025.
//

class FeedItemsMapper {
    
    private struct Root: Decodable {
        let items: [Item]
        var feed:[FeedItem] {
            return items.map{ $0.item }
        }
    }
    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
        
        var item: FeedItem {
            return FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    static func map(data: Data, response:HTTPURLResponse)  -> LoadFeedResult {
        guard response.statusCode == 200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        return .success(root.feed)
    }
}
