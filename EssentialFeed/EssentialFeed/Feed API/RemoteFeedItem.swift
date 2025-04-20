//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Animesh on 19.04.2025.
//

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
