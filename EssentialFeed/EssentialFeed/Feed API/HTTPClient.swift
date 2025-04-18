//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Akanksha on 05.04.2025.
//

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
