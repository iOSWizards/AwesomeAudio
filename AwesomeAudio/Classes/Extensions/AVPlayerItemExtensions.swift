//
//  AVPlayerItemExtension.swift
//  AwesomeMedia
//
//  Created by Evandro Harrison Hoffmann on 4/9/18.
//

import AVFoundation
import MediaPlayer

extension AVPlayerItem {
    
    public var durationInSeconds: Float {
        let durationInSeconds = Float(CMTimeGetSeconds(duration))
        return !durationInSeconds.isNaN ? durationInSeconds : 1
    }
    
    public var currentTimeInSeconds: Float {
        return Float(currentTime().seconds)
    }
    
    public var minTimeString: String {
        let time = Float64(currentTime().seconds)
        if durationInSeconds.isHours {
            return time.formatedTimeInHours
        }
        return time.formatedTimeInMinutes
    }
    
    public var maxTimeString: String {
        let time = Float64(durationInSeconds - currentTimeInSeconds)
        if durationInSeconds.isHours {
            return time.formatedTimeInHours
        }
        return time.formatedTimeInMinutes
    }
    
    public var durationString: String {
        let time = Float64(durationInSeconds)
        if durationInSeconds.isHours {
            return time.formatedTimeInHours
        }
        return time.formatedTimeInMinutes
    }
    
    // MARK: - Time
    
    public func saveTime() {
        guard var url = url else {
            return
        }
        
        url.time = currentTimeInSeconds
    }
    
    public func loadSavedTime() {

        if let time = url?.time {
            seek(to: CMTime(seconds: Double(time), preferredTimescale: currentTime().timescale), completionHandler: nil)
        }
    }
    
    public func resetTime() {
        guard var url = url else {
            return
        }
        
        url.time = 0
    }
    
    public var url: URL? {
        if let asset = self.asset as? AVURLAsset {
            // for normal media, we just return the asset url if AVURLAsset
            return asset.url
        } else if self.asset is AVComposition {
            // for subtitled media, we return the asset url from shared media params
            return AwesomeAudio.currentMedia?.url
        }
        
        return nil
    }
    
    // Item
    
    public static func item(withUrl url: URL, completion: @escaping (AAPlayerItem) -> Void) {
        urlItem(withUrl: url, completion: completion)
    }
    
    public static func urlItem(withUrl url: URL, completion: @escaping (AAPlayerItem) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let playerItem = AAPlayerItem(url: url)
            
            DispatchQueue.main.async {
                completion(playerItem)
            }
        }
    }
    
}
