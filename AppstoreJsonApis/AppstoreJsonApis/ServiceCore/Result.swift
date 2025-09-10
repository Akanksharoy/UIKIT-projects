//
//  Result.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 31.05.2025.
//

@frozen
public enum APIResult<M, E: Error> {
    case success(M)
    case failure(E)
}
