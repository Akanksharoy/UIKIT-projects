//
//  SearchResult.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 04/07/24.
//
struct SearchResult:Decodable {
    let resultCount: Int
    let results: [Apps]
}
struct Apps: Decodable {
    let description: String
    let primaryGenreName: String
    let trackName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    
}
