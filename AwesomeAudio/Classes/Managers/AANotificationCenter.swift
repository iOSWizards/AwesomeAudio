//
//  AwesomeMediaNotificationCenter.swift
//  AwesomeMedia
//
//  Created by Evandro Harrison Hoffmann on 4/6/18.
//

import Foundation
import AVFoundation

public enum MediaEvent: String {
    case playing
    case playingAudio
    case playingVideo
    case showMiniPlayer
    case hideMiniPlayer
    case paused
    case stopped
    case finished
    case failed
    case buffering
    case stoppedBuffering
    case timeUpdated
    case timedOut
    case timeStartedUpdating
    case timeFinishedUpdating
    case isGoingPortrait
    case isGoingLandscape
    case speedRateChanged
    case unknown
    case favourited
    case unfavourited
    case share
    case updatedMedia
}

func notifyMediaEvent(_ event: MediaEvent, object: AnyObject? = nil) {
    print("notification event: \(event.rawValue)")
    
    AANotificationCenter.shared.notify(event, object: object)
    
    //AwesomeAudio.updateMediaState(event: event)
}

public class AANotificationCenter: NotificationCenter {
    
    public static var shared = AANotificationCenter()
    
    public func notify(_ event: MediaEvent, object: AnyObject? = nil) {
        post(name: Notification.Name(rawValue: event.rawValue), object: object)
    }
    
    public func addObserver(_ observer: Any, selector: Selector, event: MediaEvent, object: AnyObject? = nil) {
        addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: event.rawValue), object: object)
    }
    
    public static func addObservers(_ options: AwesomeMediaNotificationCenterOptions, to: EventObserver) {
        
        if options.contains(.playing) {
            AANotificationCenter.shared.addObserver(to, selector: .playing, event: .playing)
        }
        
        if options.contains(.playingAudio) {
            AANotificationCenter.shared.addObserver(to, selector: .playingAudio, event: .playingAudio)
        }
        
        if options.contains(.playingVideo) {
            AANotificationCenter.shared.addObserver(to, selector: .playingVideo, event: .playingVideo)
        }
        
        if options.contains(.showMiniPlayer) {
            AANotificationCenter.shared.addObserver(to, selector: .showMiniPlayer, event: .showMiniPlayer)
        }
        
        if options.contains(.hideMiniPlayer) {
            AANotificationCenter.shared.addObserver(to, selector: .hideMiniPlayer, event: .hideMiniPlayer)
        }
        
        if options.contains(.paused) {
            AANotificationCenter.shared.addObserver(to, selector: .paused, event: .paused)
        }
        
        if options.contains(.stopped) {
            AANotificationCenter.shared.addObserver(to, selector: .stopped, event: .stopped)
        }
        
        if options.contains(.timeUpdated) {
            AANotificationCenter.shared.addObserver(to, selector: .timeUpdated, event: .timeUpdated)
        }
        
        if options.contains(.buffering) {
            AANotificationCenter.shared.addObserver(to, selector: .startedBuffering, event: .buffering)
        }
        
        if options.contains(.stoppedBuffering) {
            AANotificationCenter.shared.addObserver(to, selector: .stopedBuffering, event: .stoppedBuffering)
        }
        
        if options.contains(.finished) {
            AANotificationCenter.shared.addObserver(to, selector: .finishedPlaying, event: .finished)
        }
        
        if options.contains(.speedRateChanged) {
            AANotificationCenter.shared.addObserver(to, selector: .speedRateChanged, event: .speedRateChanged)
        }
        
        if options.contains(.timedOut) {
            AANotificationCenter.shared.addObserver(to, selector: .timedOut, event: .timedOut)
        }
        
        if options.contains(.favourited) {
            AANotificationCenter.shared.addObserver(to, selector: .favourited, event: .favourited)
        }
        
        if options.contains(.unfavourited) {
            AANotificationCenter.shared.addObserver(to, selector: .unfavourited, event: .unfavourited)
        }
        
        if options.contains(.share) {
            AANotificationCenter.shared.addObserver(to, selector: .share, event: .share)
        }
        
        if options.contains(.updatedMedia) {
            AANotificationCenter.shared.addObserver(to, selector: .updatedMedia, event: .updatedMedia)
        }
    }
    
    public static func removeObservers(from: EventObserver) {
        AANotificationCenter.shared.removeObserver(from)
    }
    
}

public struct AwesomeMediaNotificationCenterOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let playing = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 0)
    public static let paused = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 1)
    public static let stopped = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 2)
    public static let finished = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 3)
    public static let failed = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 4)
    public static let buffering = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 5)
    public static let stoppedBuffering = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 6)
    public static let timeUpdated = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 7)
    public static let timedOut = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 8)
    public static let timeStartedUpdating = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 9)
    public static let timeFinishedUpdating = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 10)
    public static let isGoingPortrait = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 11)
    public static let isGoingLandscape = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 12)
    public static let speedRateChanged = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 13)
    public static let playingAudio = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 14)
    public static let playingVideo = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 15)
    public static let showMiniPlayer = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 16)
    public static let hideMiniPlayer = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 17)
    public static let unknown = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 18)
    public static let favourited = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 19)
    public static let unfavourited = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 20)
    public static let share = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 21)
    public static let updatedMedia = AwesomeMediaNotificationCenterOptions(rawValue: 1 << 22)
    
    public static let basic: AwesomeMediaNotificationCenterOptions = [.playing, .paused, .finished, .buffering, .stoppedBuffering]
}

public extension Selector {
    static let playing = #selector(EventObserver.startedPlaying)
    static let playingAudio = #selector(EventObserver.startedPlayingAudio(_:))
    static let playingVideo = #selector(EventObserver.startedPlayingVideo(_:))
    static let showMiniPlayer = #selector(EventObserver.showMiniPlayer(_:))
    static let hideMiniPlayer = #selector(EventObserver.hideMiniPlayer(_:))
    static let paused = #selector(EventObserver.pausedPlaying)
    static let stopped = #selector(EventObserver.stoppedPlaying)
    static let timeUpdated = #selector(EventObserver.timeUpdated)
    static let startedBuffering = #selector(EventObserver.startedBuffering)
    static let stopedBuffering = #selector(EventObserver.stoppedBuffering)
    static let finishedPlaying = #selector(EventObserver.finishedPlaying)
    static let speedRateChanged = #selector(EventObserver.speedRateChanged)
    static let timedOut = #selector(EventObserver.timedOut)
    static let favourited = #selector(EventObserver.favourited(_:))
    static let unfavourited = #selector(EventObserver.unfavourited(_:))
    static let share = #selector(EventObserver.share(_:))
    static let updatedMedia = #selector(EventObserver.updatedMedia(_:))
}

@objc public protocol EventObserver {
    func addObservers()
    func removeObservers()
    @objc optional func startedPlaying()
    @objc optional func startedPlayingAudio(_ notification: NSNotification)
    @objc optional func startedPlayingVideo(_ notification: NSNotification)
    @objc optional func showMiniPlayer(_ notification: NSNotification)
    @objc optional func hideMiniPlayer(_ notification: NSNotification)
    @objc optional func pausedPlaying()
    @objc optional func stoppedPlaying()
    @objc optional func timeUpdated()
    @objc optional func startedBuffering()
    @objc optional func stoppedBuffering()
    @objc optional func finishedPlaying()
    @objc optional func speedRateChanged()
    @objc optional func timedOut()
    @objc optional func favourited(_ notification: NSNotification)
    @objc optional func unfavourited(_ notification: NSNotification)
    @objc optional func share(_ notification: NSNotification)
    @objc optional func updatedMedia(_ notification: NSNotification)
}
