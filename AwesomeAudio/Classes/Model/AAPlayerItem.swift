import AVFoundation

// MARK: - Responsible for handling the KVO operations that happen on the AVPlayerItem.

public enum AAPlayerItemKeyPaths: String {
    case playbackLikelyToKeepUp
    case playbackBufferFull
    case playbackBufferEmpty
    case status
    case timeControlStatus
}

public class AAPlayerItem: AVPlayerItem {
    
    private var observersKeyPath = [String: NSObject?]()
    private var keysPathArray: [AAPlayerItemKeyPaths] = [.playbackLikelyToKeepUp, .playbackBufferFull, .playbackBufferEmpty, .status, .timeControlStatus]
    
    deinit {
        for (keyPath, observer) in observersKeyPath {
            if let observer = observer {
                self.removeObserver(observer, forKeyPath: keyPath)
            }
        }
    }
    
    override public func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        super.addObserver(observer, forKeyPath: keyPath, options: options, context: context)
        if let keyPathRaw = AAPlayerItemKeyPaths(rawValue: keyPath), keysPathArray.contains(keyPathRaw) {
            if let obj = observersKeyPath[keyPath] as? NSObject {
                self.removeObserver(obj, forKeyPath: keyPath)
                observersKeyPath[keyPath] = observer
            } else {
                observersKeyPath[keyPath] = observer
            }
        }
    }
    
    override public func removeObserver(_ observer: NSObject, forKeyPath keyPath: String, context: UnsafeMutableRawPointer?) {
        super.removeObserver(observer, forKeyPath: keyPath, context: context)
        observersKeyPath[keyPath] = nil
    }
    
    public override func removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        super.removeObserver(observer, forKeyPath: keyPath)
        observersKeyPath[keyPath] = nil
    }
}
