//
//  MediaTimeManager.swift
//  AwesomeAudio
//
//  Created by Evandro Harrison on 12/04/2019.
//

import Foundation

public struct MediaTimeManager {
    
    public static var speed: Float? {
        get {
            return UserDefaults.standard.float(forKey: "awesomeMediaSpeed")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "awesomeMediaSpeed")
        }
    }
    
}

extension URL {
    public var time: Float? {
        get {
            return UserDefaults.standard.float(forKey: self.pathComponents.last ?? self.absoluteString)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: self.pathComponents.last ?? self.absoluteString)
        }
    }
}
