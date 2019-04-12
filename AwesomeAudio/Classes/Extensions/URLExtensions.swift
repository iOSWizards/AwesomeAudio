//
//  StringExtensions.swift
//  AwesomeAudio
//
//  Created by Evandro Harrison on 25/02/2019.
//

import Foundation

extension URL {
    static var documentsDirectory: URL {
        return FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static func destination(for folder: String) -> URL {
        return URL.documentsDirectory.appendingPathComponent(folder)
    }
    
    func offlineFileDestination(withFolder folder: String? = nil) -> URL {
        if let folder = folder {
            return URL.destination(for: folder).appendingPathComponent(lastPathComponent)
        }
        return URL.documentsDirectory.appendingPathComponent(lastPathComponent)
    }
    
    var offlineFileName: String {
        return lastPathComponent
    }
    
    func createFolder() {
        do {
            try FileManager().createDirectory(at: self, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("folder could not be created")
        }
    }
    
    func offlineFileExists(withFolder folder: String? = nil) -> Bool {
        return FileManager().fileExists(atPath: offlineFileDestination(withFolder: folder).path)
    }
    
    func offlineURLIfAvailable(withFolder folder: String? = nil) -> URL {
        if offlineFileExists(withFolder: folder) {
            return offlineFileDestination(withFolder: folder)
        }
        return self
    }
    
    func deleteOfflineFile(withFolder folder: String? = nil) -> Bool {
        guard offlineFileExists(withFolder: folder) else {
            return false
        }
        
        do {
            try FileManager().removeItem(at: offlineFileDestination(withFolder: folder))
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }
    
    func moveOfflineFile(to: URL, completion:@escaping (Bool) -> Void) {
        do {
            try FileManager().moveItem(at: self, to: to)
            print("File moved to documents folder: \(to.absoluteString)")
            completion(true)
        } catch let error as NSError {
            print(error.localizedDescription)
            completion(false)
        }
    }
}
