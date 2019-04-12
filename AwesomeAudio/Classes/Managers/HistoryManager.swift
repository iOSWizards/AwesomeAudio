//
//  PlayerHistory.swift
//  AwesomeAudio
//
//  Created by Evandro Harrison on 12/04/2019.
//

import Foundation

public class HistoryManager {
    
    public static let shared: HistoryManager = HistoryManager()
    private var played: [AAMedia] = []
    public var currentMedia: AAMedia?
    
    public func played(_ media: AAMedia) {
        played.append(media)
    }
    
    public func playing(_ media: AAMedia) {
        if let currentMedia = currentMedia {
            played(currentMedia)
        }
        
        currentMedia = media
    }
    
}
