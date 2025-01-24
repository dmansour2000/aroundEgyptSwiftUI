//
//  DiskCacheFileManageable.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation

public protocol DiskCacheFileManagable {
    func assureDirectoryExists(filePathURL: URL) throws
    func filePathURL(forKey key: String) throws -> URL
    func write(_ data: Data, to url: URL) throws
    func data(of url: URL) throws -> Data
}
