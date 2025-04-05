//
//  RemoteFeedLoaderTests.swift
//  EssentialFeed
//
//  Created by Animesh on 02.04.2025.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    init(url: URL, client: HTTPClient){
        self.url = url
        self.client = client
    }
    func load () {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
    
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    func get(from url: URL) {
        requestedURL = url
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string:"https://a-given-url.com")!
        let clientCalled = HTTPClientSpy()
        
        _ = RemoteFeedLoader(url: url, client: clientCalled)
        
        XCTAssertEqual(clientCalled.requestedURL, url)
        
    }
    func test_load_requestDataFromURL() {
        let url = URL(string:"https://a-given-url.com")!
        let clientCalled = HTTPClientSpy()
        
        let sut = RemoteFeedLoader(url: url, client: clientCalled)
        
        sut.load()
        
        XCTAssertNotNil(clientCalled.requestedURL)
        
        
    }
    
}
