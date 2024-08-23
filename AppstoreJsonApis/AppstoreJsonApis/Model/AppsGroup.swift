//
//  AppsGroup.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 19/08/24.
//

import Foundation

struct AppsGroup: Decodable{
    let feed: Feed
}
struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}
struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
extension AppsGroup {
    static var empty: AppsGroup {
        return AppsGroup(feed: Feed(title: "", results: []))
    }
}

extension Feed {
    static var empty: Feed {
        return Feed(title: "", results: [])
    }
}
