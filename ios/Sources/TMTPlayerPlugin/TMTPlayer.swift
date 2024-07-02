import UIKit
import AVKit
import Combine
import MediaPlayer

@objc public class TMTPlayerItem: NSObject {
    
    var url: String
    var title: String
    var artist: String
    var image: String

    public init(url: String, title: String, artist: String, image: String) {
        self.url = url
        self.title = title
        self.artist = artist
        self.image = image
    }
}

@objc public class TMTPlayer: NSObject {
    
    //  MARK: Singleton
    
    public static let shared = TMTPlayer()
    
    private override init() { 
        super.init()
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        self.handlePlayerDidEndPlayingObserver()
        self.setupRemoteCommandCenter()
    }
    
    //  MARK: Public Properties

    private var avPlayerDidEndPlaying: (() -> Void)?

    //  MARK: Private Properties

    private var avPlayer = AVPlayer()
    private var cancellables: Set<AnyCancellable> = []

    //  MARK: Public Methods

    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }

    public func play(item: TMTPlayerItem, avPlayerDidEndPlaying: @escaping (() -> Void)) {
        
        guard let url = URL(string: item.url) else {
            return
        }
        
        self.avPlayerDidEndPlaying = avPlayerDidEndPlaying
        let avPlayerItem = AVPlayerItem(url: url)
        self.avPlayer.replaceCurrentItem(with: avPlayerItem)
        self.avPlayer.play()
        self.setupNowPlaying(avPlayerItem: avPlayerItem, tmtPlayerItem: item)
    }

    public func pause() {
        
        self.avPlayer.pause()
    }

    //  MARK: Private Methods

    private func handlePlayerDidEndPlayingObserver() {
        
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
        .sink { [weak self] _ in
            self?.avPlayer.seek(to: CMTime.zero)
            self?.avPlayerDidEndPlaying?()
        }
        .store(in: &cancellables)
    }
    
    private func setupNowPlaying(avPlayerItem: AVPlayerItem, tmtPlayerItem: TMTPlayerItem) {

        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = tmtPlayerItem.title
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = avPlayerItem.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = avPlayerItem.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.avPlayer.rate

        if tmtPlayerItem.image.isEmpty {
            // Set the metadata
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        } else {

            DispatchQueue.global().async {
                if let url = URL(string: tmtPlayerItem.image) {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        let artwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (_ size : CGSize) -> UIImage in
                            return image
                        })
                        nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                        
                        DispatchQueue.main.async {
                            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                        }
                    }
                }
            }
        }
        
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }

    private func setupRemoteCommandCenter() {
        
        let commandCenter = MPRemoteCommandCenter.shared();
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] event in
            self?.avPlayer.play()
            return .success
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] event in
            self?.avPlayer.pause()
            return .success
        }

        /*
         commandCenter.nextTrackCommand.isEnabled = true
         commandCenter.nextTrackCommand.addTarget { [weak self] event in
             self?.avPlayer.pause()
             self?.startNextMediaItem()
             return .success
         }

         commandCenter.previousTrackCommand.isEnabled = true
         commandCenter.previousTrackCommand.addTarget { [weak self] event in
             self?.avPlayer.pause()
             self?.startNextMediaItem()
             return .success
         }
         */

        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in

            guard let self else {
                return .commandFailed
            }
            
            let playerRate = self.avPlayer.rate
            if let event = event as? MPChangePlaybackPositionCommandEvent {
                let seekToTime = CMTime(seconds: event.positionTime, preferredTimescale: CMTimeScale(1000))
                self.avPlayer.seek(to: seekToTime) { [weak self] success in
                    if success {
                        self?.avPlayer.rate = playerRate
                    }
                }
                return .success
             }

            return .commandFailed
        }
    }

}

private extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
