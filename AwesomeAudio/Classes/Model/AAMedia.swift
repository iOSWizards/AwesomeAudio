//
//  AAMedia.swift
//  AwesomeAudio
//
//  Created by Evandro Harrison on 12/04/2019.
//

import Foundation

public struct AAMedia {
    
    public let title: String?
    public let desc: String?
    public let cover: String?
    public let author: String?
    private let mediaUrlString: String
    private let backgroundUrlString: String?
    
    public init(media: String,
                background: String? = nil,
                title: String? = nil,
                desc: String? = nil,
                cover: String? = nil,
                author: String? = nil) {
        self.mediaUrlString = media
        self.backgroundUrlString = background
        self.title = title
        self.desc = desc
        self.cover = cover
        self.author = author
    }
    
    public var url: URL? {
        return mediaUrlString.url()?.offlineURLIfAvailable()
    }
    
    public var backgroundUrl: URL? {
        return backgroundUrlString?.url()?.offlineURLIfAvailable()
    }
}
