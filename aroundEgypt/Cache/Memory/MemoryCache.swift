//
//  MemoryCache.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation

public final class MemoryCache<Value>: CacheStorage where Value: Codable {
        
    private lazy var memoryCache: NSCache<NSString, NSData> = {
        let imageCache = NSCache<NSString, NSData>()
        imageCache.countLimit = countLimit
        return imageCache
    }()
    
    private let countLimit: Int
    
    public init(countLimit: Int) {
        self.countLimit = countLimit
    }
        
    public func value(forKey key: String) throws -> Value? {
        try memoryCache
            .object(forKey: NSString(string: key))
            .flatMap { Data(referencing: $0) }
            .flatMap { try JSONDecoder().decode(Value.self, from: $0) }
    }
    
    public func save(_ value: Value, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        memoryCache.setObject(NSData(data: data), forKey: NSString(string: key))
    }

}
