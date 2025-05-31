//
//  SearchResult.swift
//  AppstoreJsonApis
//
//  Created by Akanksha on 04/07/24.
//
struct SearchResult:Decodable {
    let resultCount: Int
    let results: [Apps]
}

struct Apps: Decodable {
    let primaryGenreName: String
    let trackName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
}
