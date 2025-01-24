//
//  CacheStorage.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation

public protocol CacheStorage {
    associatedtype Value
    
    func value(forKey key: String) throws -> Value?
    func save(_ value: Value, forKey key: String) throws
}
