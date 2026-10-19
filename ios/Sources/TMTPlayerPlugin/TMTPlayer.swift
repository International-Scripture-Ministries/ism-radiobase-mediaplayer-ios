import UIKit
import AVKit
import Combine
import MediaPlayer

public extension Notification.Name {
    static let tmtPlayerPlaybackStateDidChange = Notification.Name("TMTPlayerPlaybackStateDidChange")
}

public enum UserDefaultsKeys: String {
    case statisticsOfLastPlayedMediaBeforeAppClose
}

public enum CurrentMediaItemPlaybackState: String {
    case none, playing, paused, complete
    
    var isMediaPlayingOrPaused: Bool {
        self == .playing || self == .paused
    }
}

public enum MediaItemState: String {
    case incomplete = "INCOMPLETE", complete = "COMPLETE"
}

@objc public class TMTPlayerItem: NSObject, Decodable {
    
    //  Data from Ionic to plugin
    var url: String
    var title: String
    var artist: String
    var image: String
    var duration: String
    var isStreaming: Bool
    var isPlaying: Bool
    var isStudy: Bool
    var isLocalFileUrl: Bool
    var playbackPositionInSeconds: Double
    
    //  Data from plugin to Ionic
    var lastPlayedDateTime: TimeInterval = 0.0
    var lastPlaybackPositionInSeconds: Double = 0.0
    var durationInSeconds = 0.0
    var state: MediaItemState = .incomplete
    var playbackState: CurrentMediaItemPlaybackState = .none
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case artist
        case image
        case duration
        case isStreaming
        case isPlaying
        case isStudy
        case isLocalFileUrl
        case playbackPositionInSeconds
    }
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.artist = try container.decodeIfPresent(String.self, forKey: .artist) ?? ""
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        self.isStreaming = try container.decodeIfPresent(Bool.self, forKey: .isStreaming) ?? false
        self.isPlaying = try container.decodeIfPresent(Bool.self, forKey: .isPlaying) ?? false
        self.isStudy = try container.decodeIfPresent(Bool.self, forKey: .isStudy) ?? false
        self.isLocalFileUrl = try container.decodeIfPresent(Bool.self, forKey: .isLocalFileUrl) ?? false
        self.playbackPositionInSeconds = try container.decodeIfPresent(Double.self, forKey: .playbackPositionInSeconds) ?? 0.0
    }
    
    func getStatistics() -> [String: String] {
        
        var json = [String: String]()
        json["url"] = self.url
        json["isLocalFileUrl"] = self.isLocalFileUrl ? "1" : "0"
        json["state"] = self.state.rawValue
        json["duration"] = self.duration
        json["durationInSeconds"] = "\(self.durationInSeconds)"
        json["position"] = "\(self.lastPlaybackPositionInSeconds)"
        json["epoch"] = "\(self.lastPlayedDateTime)"
        return json
    }
    
    func getPlaybackInfo() -> [String: String] {
        
        var json = [String: String]()
        json["url"] = self.url
        json["isLocalFileUrl"] = self.isLocalFileUrl ? "1" : "0"
        json["duration"] = self.duration
        json["durationInSeconds"] = "\(self.durationInSeconds)"
        json["position"] = "\(self.lastPlaybackPositionInSeconds)"
        json["state"] = self.playbackState.rawValue
        return json
    }
}

@objc public class TMTPlayer: NSObject {
    
    //  MARK: Singleton
    
    public static let shared = TMTPlayer()
    
    private override init() {
        super.init()
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [])
        try? AVAudioSession.sharedInstance().setActive(true)
        self.handleAppWillTerminateObserver()
        self.handlePlayerDidEndPlayingObserver()
        self.setupRemoteCommandCenter()
        
        self.avPlayer.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 1),
            queue: nil) { [weak self] cmTime in
                guard let self = self else { return }
                let currentItemDuration = self.avPlayer.currentItem?.duration.seconds ?? 0.0
                if cmTime.seconds >= currentItemDuration {
                    self.mediaList[safe: self.currentMediaItemIndex]?.lastPlaybackPositionInSeconds = currentItemDuration
                } else {
                    self.mediaList[safe: self.currentMediaItemIndex]?.lastPlaybackPositionInSeconds = cmTime.seconds
                }
                self.mediaList[safe: self.currentMediaItemIndex]?.durationInSeconds = currentItemDuration
                self.updateSeekPositionOnLockScreen()
            }
    }
    
    //  MARK: Public Properties

    //  MARK: Private Properties

    private var currentAVPlayerRate: Float = 1.0
    private var currentMediaItemIndex = -1
    private var mediaList = [TMTPlayerItem]()
    private var mediaItemDidEndPlayingSuccess: ((TMTPlayerItem) -> Void)?
    private var avPlayer = AVPlayer()
    private var cancellables: Set<AnyCancellable> = []
    private let skipInterval = NSNumber(integerLiteral: 15)

    //  MARK: Public Methods

    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }

    public func initialSetup() {
        //  Do nothing
    }
    
    public func startPlayingMediaList(_ list: [TMTPlayerItem], mediaItemDidEndPlayingSuccess: @escaping ((TMTPlayerItem) -> Void)) {
        
        self.mediaList = list
        self.mediaItemDidEndPlayingSuccess = mediaItemDidEndPlayingSuccess
        self.startPlayerForMediaList()
    }
    
    public func checkPlayingMediaList( mediaItemDidEndPlayingSuccess: @escaping ((TMTPlayerItem) -> Void)) {
        self.mediaItemDidEndPlayingSuccess = mediaItemDidEndPlayingSuccess
    }

    public func addMediaToList(_ list: [TMTPlayerItem]) {
        self.mediaList.append(contentsOf: list)
    }
    
    public func clearMediaList() {

        self.pause()
        self.avPlayer.replaceCurrentItem(with: nil)
        self.mediaList = []
        self.currentMediaItemIndex = -1
        NotificationCenter.default.post(name: .tmtPlayerPlaybackStateDidChange, object: self)
    }

    @discardableResult
    public func play() -> Bool {
        
        if self.avPlayer.currentItem != nil {
            self.avPlayer.play()
            self.mediaList[safe: self.currentMediaItemIndex]?.lastPlayedDateTime = Date().timeIntervalSince1970
            self.mediaList[safe: self.currentMediaItemIndex]?.playbackState = .playing
            self.updateCurrentPlayerRate()
            self.updateNowPlayingPlaybackState(.playing, rate: self.currentAVPlayerRate)
            NotificationCenter.default.post(name: .tmtPlayerPlaybackStateDidChange, object: self)
            return true
        }
        
        return false
    }

    public func pause() {
        
        self.avPlayer.pause()
        self.mediaList[safe: self.currentMediaItemIndex]?.playbackState = .paused
        self.updateNowPlayingPlaybackState(.paused, rate: 0)
        NotificationCenter.default.post(name: .tmtPlayerPlaybackStateDidChange, object: self)
    }

    public func getCurrentPlayerItemSeekTime() -> Double {
        
        return self.avPlayer.currentTime().seconds
    }

    public func fetchMediaListStatistics() -> Array<[String:String]> {
        
        let allCompletedItems = self.mediaList.filter { $0.state == .complete }
        var list = allCompletedItems.compactMap { $0.getStatistics() }

        if let firstInCompletedItem = self.mediaList.filter ({ $0.state == .incomplete }).first {
            list.append(firstInCompletedItem.getStatistics())
        }

        return list
    }

    public func updatePlayerRate(_ rate: Float) {
        
        self.currentAVPlayerRate = rate
        self.avPlayer.rate = rate
    }

    public func getCurrentMediaItemPlaybackInfo() -> [String: String] {
        
        guard let currentItem = self.mediaList[safe: self.currentMediaItemIndex] else {
            print("current mediaList does not have media item at index: \(self.currentMediaItemIndex)")
            return [:]
        }
        
        return currentItem.getPlaybackInfo()
    }
    
    public func seekToTimeInSeconds(_ seconds: Double) {
        
        let playerRate = self.avPlayer.rate
        let seekToTime = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(1000))
        self.avPlayer.seek(to: seekToTime) { [weak self] success in
            guard let self else { return }
            if success {
                self.avPlayer.rate = playerRate
                self.updateSeekPositionOnLockScreen()
            }
        }
    }

    public func getStatisticsOfLastPlayedMediaBeforeAppClose() -> Array<[String:String]> {
        
        if let statistics = UserDefaults.standard.value(forKey: UserDefaultsKeys.statisticsOfLastPlayedMediaBeforeAppClose.rawValue) as? Array<[String:String]> {
            return statistics
        }
        return [[:]]
    }

    public func removeStatisticsOfLastPlayedMedia() {
        
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.statisticsOfLastPlayedMediaBeforeAppClose.rawValue)
    }

    public func removeAllMediaItemsExceptCurrentPlayingItem() {
        
        self.mediaList.removeAll { !$0.playbackState.isMediaPlayingOrPaused }
//        self.mediaList.enumerated().compactMap { $0.offset == self.currentMediaItemIndex ? $0.element : nil }
        self.currentMediaItemIndex = 0
    }
    
    
    //  MARK: Private Methods

    private func startPlayerForMediaList() {
        print("mediaList  \(self.mediaList.isEmpty)")
        guard !self.mediaList.isEmpty else {
            return
        }
        self.playNextMediaItem()
    }
    
    private func playNextMediaItem() {
        
        //  default value is -1
        self.currentMediaItemIndex = self.currentMediaItemIndex + 1
        
        guard let mediaItem = self.getMediaItemFromCurrentIndex() else {
            print("mediaList does not have any media item at index \(self.currentMediaItemIndex)")
            //  reset current media item index
            self.currentMediaItemIndex = -1
            
            return
        }
        self.play(item: mediaItem)
    }
    
    private func getMediaItemFromCurrentIndex() -> TMTPlayerItem? {
        self.mediaList[safe: self.currentMediaItemIndex]
    }
    
    private func play(item: TMTPlayerItem) {
        
        var mediaUrl: URL?
        if item.isLocalFileUrl {
            if #available(iOS 16.0, *) {
                mediaUrl = URL(filePath: item.url)
            } else {
                mediaUrl = URL(string: item.url)
            }
        } else {
            mediaUrl = URL(string: item.url)
        }
        
        guard let url = mediaUrl else {
            print("url of media item can not be nil")
            return
        }
        let avPlayerItem = AVPlayerItem(url: url)
        self.avPlayer.replaceCurrentItem(with: avPlayerItem)
        if item.playbackPositionInSeconds > 0.0 {
            self.avPlayer.seek(to: CMTime(seconds: item.playbackPositionInSeconds, preferredTimescale: 1), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
        try? AVAudioSession.sharedInstance().setActive(true)
        self.play()
        self.setupNowPlaying(avPlayerItem: avPlayerItem, tmtPlayerItem: item)
    }

    private func updateCurrentPlayerRate() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            self.avPlayer.rate = self.currentAVPlayerRate
        }
    }
    
    private func handleAppWillTerminateObserver() {
        
        NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)
            .sink { _ in
                let list = self.fetchMediaListStatistics()
                UserDefaults.standard.set(list, forKey: UserDefaultsKeys.statisticsOfLastPlayedMediaBeforeAppClose.rawValue)
                UserDefaults.standard.synchronize()

        }
        .store(in: &cancellables)
    }

    private func handlePlayerDidEndPlayingObserver() {
        
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
        .sink { [weak self] _ in
            guard let self = self else { return }

            self.avPlayer.seek(to: CMTime.zero)
            if let mediaItem = self.getMediaItemFromCurrentIndex() {
                self.mediaItemDidEndPlayingSuccess?(mediaItem)
                self.mediaList[safe: self.currentMediaItemIndex]?.state = .complete
                self.mediaList[safe: self.currentMediaItemIndex]?.playbackState = .complete
            }
            self.playNextMediaItem()
        }
        .store(in: &cancellables)
    }
    
    private func updateSeekPositionOnLockScreen() {
        
        if var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo {
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.avPlayer.currentTime().seconds
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.avPlayer.rate
            let duration = self.avPlayer.currentItem?.duration.seconds ?? 0
            if duration.isFinite && duration > 0 {
                nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
            }
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }
    }

    private func updateNowPlayingPlaybackState(_ state: MPNowPlayingPlaybackState, rate: Float) {
        if var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo {
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = rate
            nowPlayingInfo[MPNowPlayingInfoPropertyDefaultPlaybackRate] = self.currentAVPlayerRate
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }
        MPNowPlayingInfoCenter.default().playbackState = state
    }

    private func artworkURL(for source: String) -> URL? {
        if let url = URL(string: source), url.scheme != nil {
            return url
        }

        if source.hasPrefix("/") {
            return URL(fileURLWithPath: source)
        }

        let relativePath = source.hasPrefix("./") ? String(source.dropFirst(2)) : source
        let publicURL = Bundle.main.bundleURL
            .appendingPathComponent("public", isDirectory: true)
            .appendingPathComponent(relativePath)
        if FileManager.default.fileExists(atPath: publicURL.path) {
            return publicURL
        }

        let bundleURL = Bundle.main.bundleURL.appendingPathComponent(relativePath)
        return FileManager.default.fileExists(atPath: bundleURL.path) ? bundleURL : nil
    }
    
    private func setupNowPlaying(avPlayerItem: AVPlayerItem, tmtPlayerItem: TMTPlayerItem) {
        // Clear previous queue-like metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil

        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = tmtPlayerItem.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = tmtPlayerItem.artist
        let elapsed = avPlayerItem.currentTime().seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = elapsed.isFinite ? elapsed : 0
        let duration = avPlayerItem.duration.seconds
        if duration.isFinite && duration > 0 {
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.currentAVPlayerRate
        nowPlayingInfo[MPNowPlayingInfoPropertyDefaultPlaybackRate] = self.currentAVPlayerRate
        nowPlayingInfo[MPMediaItemPropertyMediaType] = MPMediaType.anyAudio.rawValue

        // Publish text and playback state immediately. Artwork is optional and must
        // never prevent CarPlay from receiving the rest of the metadata.
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing

        if !tmtPlayerItem.image.isEmpty {
            let expectedTitle = tmtPlayerItem.title
            DispatchQueue.global().async {
                if let url = self.artworkURL(for: tmtPlayerItem.image) {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        let artwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (_ size : CGSize) -> UIImage in
                            return image
                        })
                        DispatchQueue.main.async {
                            guard
                                var current = MPNowPlayingInfoCenter.default().nowPlayingInfo,
                                current[MPMediaItemPropertyTitle] as? String == expectedTitle
                            else { return }
                            current[MPMediaItemPropertyArtwork] = artwork
                            MPNowPlayingInfoCenter.default().nowPlayingInfo = current
                        }
                    }
                }
            }
        }
        self.setupRemoteCommandCenter()
    }

    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared();

        // The radio player uses the same process-wide command center. Replace its
        // handlers when TMTPlayer becomes active so one button controls one player.
        commandCenter.playCommand.removeTarget(nil)
        commandCenter.pauseCommand.removeTarget(nil)
        commandCenter.skipForwardCommand.removeTarget(nil)
        commandCenter.skipBackwardCommand.removeTarget(nil)
        commandCenter.changePlaybackPositionCommand.removeTarget(nil)

        // Explicitly disable next/previous track and seek commands
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        commandCenter.seekForwardCommand.isEnabled = false
        commandCenter.seekBackwardCommand.isEnabled = false

        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] event in
            self?.play()
            return .success
        }

        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] event in
            self?.pause()
            return .success
        }

        // Only enable skip forward/backward commands (15s)
        commandCenter.skipForwardCommand.isEnabled = true
        commandCenter.skipForwardCommand.preferredIntervals = [self.skipInterval]
        commandCenter.skipForwardCommand.addTarget { event in
            guard let _ = event.command as? MPSkipIntervalCommand else {
                return .noSuchContent
            }
            let newTime = self.avPlayer.currentTime() + CMTime(seconds: self.skipInterval.doubleValue, preferredTimescale: .max)
            self.avPlayer.seek(to: newTime)
            self.updateSeekPositionOnLockScreen()
            return .success
        }

        commandCenter.skipBackwardCommand.isEnabled = true
        commandCenter.skipBackwardCommand.preferredIntervals = [self.skipInterval]
        commandCenter.skipBackwardCommand.addTarget { event in
            guard let _ = event.command as? MPSkipIntervalCommand else {
                return .noSuchContent
            }
            let newTime = self.avPlayer.currentTime() - CMTime(seconds: self.skipInterval.doubleValue, preferredTimescale: .max)
            self.avPlayer.seek(to: newTime)
            self.updateSeekPositionOnLockScreen()
            return .success
        }

        // Ensure these are always disabled (no re-enabling logic elsewhere)
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        commandCenter.seekForwardCommand.isEnabled = false
        commandCenter.seekBackwardCommand.isEnabled = false

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
