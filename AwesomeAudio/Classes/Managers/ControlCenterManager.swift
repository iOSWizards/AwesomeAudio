//
//  ControlCenterManager.swift
//  AwesomeAudio
//
//  Created by Evandro Harrison on 12/04/2019.
//

import AVFoundation
import MediaPlayer

class ControlCenterManager {
    
    static func configBackgroundPlay(_ media: AAMedia) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [])
        }catch{
            print("Something went wrong creating audio session... \(error)")
            return
        }
        
        //controls
        addPlayerControls()
        
        // update control center
        updateControlCenter(media)
        updateControlCenterImage(media)
    }
    
    // MARK: - Player controls
    
    static func addPlayerControls() {
        DispatchQueue.main.async {
            UIApplication.shared.beginReceivingRemoteControlEvents()
        }
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        //play/pause
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            AwesomeAudio.pause()
            
            return .success
        }
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            AwesomeAudio.play()
            
            return .success
        }
        
        /*commandCenter.stopCommand.isEnabled = true
         commandCenter.stopCommand.addTarget(self, action: .ccStop)*/
        
        /*commandCenter.togglePlayPauseCommand.isEnabled = true
         commandCenter.togglePlayPauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
         return .success
         }*/
        
        /*//seek
         commandCenter.seekForwardCommand.isEnabled = true
         commandCenter.seekForwardCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
         return .success
         }
         
         commandCenter.seekBackwardCommand.isEnabled = true
         commandCenter.seekBackwardCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
         return .success
         }*/
        
        //skip
        commandCenter.skipForwardCommand.isEnabled = true
        commandCenter.skipForwardCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            AwesomeAudio.skip(15)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                if let media = AwesomeAudio.currentMedia {
                    ControlCenterManager.updateControlCenter(media)
                }
            })
            
            return .success
        }
        
        commandCenter.skipBackwardCommand.isEnabled = true
        commandCenter.skipBackwardCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            AwesomeAudio.skip(-15)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                if let media = AwesomeAudio.currentMedia {
                    ControlCenterManager.updateControlCenter(media)
                }
            })
            
            return .success
        }
    }
    
    static func removePlayerControls(){
        UIApplication.shared.endReceivingRemoteControlEvents()
    }
    
    // MARK: - Media Info
    
    static var mediaInfo: [String: AnyObject]{
        get {
            let infoCenter = MPNowPlayingInfoCenter.default()
            
            if infoCenter.nowPlayingInfo == nil {
                infoCenter.nowPlayingInfo = [String: AnyObject]()
            }
            
            return infoCenter.nowPlayingInfo! as [String : AnyObject]
        }
        set{
            let infoCenter = MPNowPlayingInfoCenter.default()
            infoCenter.nowPlayingInfo = newValue
        }
    }
    
    static func updateControlCenter(_ media: AAMedia) {
        var nowPlayingInfo = mediaInfo
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = NSNumber(value: AwesomeAudio.currentTimeInSeconds)
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = NSNumber(value: AwesomeAudio.durationInSeconds)
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = NSNumber(value: AwesomeAudio.rate)
        
        if let author = media.author {
            nowPlayingInfo[MPMediaItemPropertyArtist] = author as AnyObject?
        }
        
        if let title = media.title {
            nowPlayingInfo[MPMediaItemPropertyTitle] = title as AnyObject?
        }
        
        mediaInfo = nowPlayingInfo
    }
    
    static func updateControlCenterImage(_ media: AAMedia) {
        if let url = media.cover?.url() {
            UIImage.load(from: url) { (image) in
                var nowPlayingInfo = mediaInfo
                
                if let image = image {
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (size) -> UIImage in
                        return image
                    })
                    
                    mediaInfo = nowPlayingInfo
                }
            }
        }
    }
    
    static func resetControlCenter() {
        mediaInfo = [:]
    }
}
