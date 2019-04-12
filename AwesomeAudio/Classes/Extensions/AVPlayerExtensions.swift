//
//  AVPlayerExtensions.swift
//  AwesomeMedia
//
//  Created by Evandro Harrison Hoffmann on 4/10/18.
//

import AVFoundation

extension AVPlayer {
    
    var currentItemUrl: URL? {
        return currentItem?.url
    }
    
    func isCurrentItem(withUrl url: URL?) -> Bool {
        guard let url = url else {
            return false
        }
        
        return currentItemUrl == url
    }
    
    func isCurrentItem(_ media: AAMedia) -> Bool {
        let url = media.url
        return isCurrentItem(withUrl: url) || isCurrentItem(withUrl: url?.offlineFileDestination()) || url == AwesomeAudio.currentMedia?.url
    }
    
    func currentItem(ifSameUrlAs url: URL?) -> AVPlayerItem? {
        guard let url = url else {
            return nil
        }
        
        guard isCurrentItem(withUrl: url) else {
            return nil
        }
        
        return currentItem
    }
    
    func currentItem(_ media: AAMedia) -> AVPlayerItem? {
        return currentItem(ifSameUrlAs: media.url)
    }
    
    var isPlaying: Bool {
        return rate != 0
    }
    
    func isPlaying(withUrl url: URL) -> Bool {
        return isCurrentItem(withUrl: url) && isPlaying
    }
    
    func isPlaying(_ media: AAMedia) -> Bool {
        return isCurrentItem(media) && isPlaying
    }
    
    func playingMedia(ifPlayingAnyFrom medias: [AAMedia]) -> AAMedia? {
        guard isPlaying else {
            return nil
        }
        
        for media in medias where isCurrentItem(media) {
            return media
        }
        
        return nil
    }
    
    // MARK: - Controls
    func seek(toTime time: Double, pausing: Bool = true) {
        if pausing {
            AwesomeAudio.pause()
        }
        
        currentItem?.seek(to: CMTime(seconds: time, preferredTimescale: currentTime().timescale), completionHandler: nil)
        
        notifyMediaEvent(.timeUpdated, object: currentItem)
    }
    
    func seek(withStep step: Double) {
        var time = CMTimeGetSeconds(currentTime()) + step
        
        if time <= 0 {
            time = 0
        } else if time >= Double(currentItem?.durationInSeconds ?? 0) {
            time = Double(currentItem?.durationInSeconds ?? 0)
        }
        
        seek(toTime: time, pausing: false)
    }
    
    func seekBackward(step: Double = PlayerConfigurations.backwardForwardStep) {
        seek(withStep: -step)
    }
    
    func seekForward(step: Double = PlayerConfigurations.backwardForwardStep) {
        seek(withStep: step)
    }
    
    func stop(resetTime: Bool = false) {
        // pause player
        pause()
        
        // reset the saved time
        if resetTime {
            currentItem?.resetTime()
        }
        
        // reset control center
        ControlCenterManager.resetControlCenter()
        
        // wipe out the existance of the media
        replaceCurrentItem(with: nil)
        
        notifyMediaEvent(.stopped)
    }
    
    func adjustSpeed() {
        rate = playbackSpeed.rawValue
    }
    
    func toggleSpeed() {
        PlayerSpeedManager.toggleSpeed()
        adjustSpeed()
    }
}
