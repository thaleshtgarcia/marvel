//
//  LocalFileCache.swift
//  Marvel
//
//  Created by thales.garcia on 17/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

// MARK: - Class - Cache layer
class LocalFileCache {
    
    class func save(response: SuperHero, fileName: String) {
        
        guard let fileUrl = LocalFileCache.documentsDirectoryUrl(with: fileName) else { return }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(response)
            try data.write(to: fileUrl, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    class func load(with fileName: String) -> Any? {
        
        guard let fileUrl = LocalFileCache.documentsDirectoryUrl(with: fileName) else { return nil }
        
        if FileManager.default.fileExists(atPath: fileUrl.relativePath) {
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                let cachedObject = try decoder.decode(SuperHero.self, from: data)
                return cachedObject
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return nil
    }
    
    class func removeAllFiles() {
        guard let cacheDirectoryUrl = LocalFileCache.documentsDirectoryUrl() else { return }
        
        if FileManager.default.fileExists(atPath: cacheDirectoryUrl.relativePath) {
            _ = try? FileManager.default.removeItem(atPath: cacheDirectoryUrl.relativePath)
        }
    }
    
    class func remove(with fileName: String) {
        guard let fileUrl = LocalFileCache.documentsDirectoryUrl(with: fileName) else { return }
        
        if FileManager.default.fileExists(atPath: fileUrl.relativePath) {
            _ = try? FileManager.default.removeItem(at: fileUrl)
        }
    }
    
    //Private methods
    class fileprivate func documentsDirectoryUrl(with name: String? = nil) -> URL? {
        guard let documentDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let customDirectoryURL = documentDirectoryURL.appendingPathComponent("custom")
        
        if FileManager.default.fileExists(atPath: customDirectoryURL.path) == false {
            do {
                try FileManager.default.createDirectory(at: customDirectoryURL, withIntermediateDirectories: false, attributes: nil)
            } catch { }
        }
        
        if let fileName = name {
            return customDirectoryURL.appendingPathComponent("\(fileName).json")
        }
        
        return customDirectoryURL
    }
}
