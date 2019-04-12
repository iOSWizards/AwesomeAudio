import AVKit

public final class AwesomeAudio {
    
    public static let shared: AwesomeAudio = AwesomeAudio()
    
    public var avPlayer: AVPlayer = AVPlayer()
    public var backgroundAvPlayer: AVPlayer = AVPlayer()
    
    public static func play(_ media: AAMedia?) {
        guard let media = media else {
            return
        }
        
        guard let url = media.url else {
            return
        }
        
        let item = AVPlayerItem(url: url)
        shared.avPlayer.replaceCurrentItem(with: item)
    }
    
    // MARK: - Information
    
    public static var currentMedia: AAMedia? {
        return HistoryManager.shared.currentMedia
    }
    
    public static var currentTimeInSeconds: Double {
        return Double(shared.avPlayer.currentItem?.currentTimeInSeconds ?? 0)
    }
    
    public static var durationInSeconds: Double {
        return Double(shared.avPlayer.currentItem?.durationInSeconds ?? 0)
    }
    
    public static var rate: Double {
        return Double(shared.avPlayer.rate)
    }
    
    // MARK: - Controls
    
    public static func play() {
        shared.avPlayer.play()
        shared.backgroundAvPlayer.play()
    }
    
    public static func pause() {
        shared.avPlayer.pause()
        shared.backgroundAvPlayer.pause()
    }
    
    public static func skip(_ time: Double) {
        shared.avPlayer.seek(withStep: time)
    }
    
}
