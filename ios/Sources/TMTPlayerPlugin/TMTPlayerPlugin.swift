import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(TMTPlayerPlugin)
public class TMTPlayerPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "TMTPlayerPlugin"
    public let jsName = "TMTPlayer"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "playMediaList", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "addMediaToList", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "clearMediaList", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "play", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pause", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getCurrentPlayerItemSeekTime", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "fetchMediaListStatistics", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "updatePlayerRate", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getCurrentMediaItemPlaybackInfo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "removeAllMediaItemsExceptCurrentPlayingItem", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "seekToTimeInSeconds", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "checkPlayingMediaList", returnType: CAPPluginReturnPromise)
    ]
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": value
        ])
    }

    @objc public func playMediaList(_ call: CAPPluginCall) {
        
        guard let mediaListString = call.getString("mediaList") else {
            call.reject("mediaList key-value is missing in request")
            return
        }
        guard let data = mediaListString.data(using: .utf8) else {
            call.reject("Unable to convert string to data")
            return
        }
        guard let mediaList = try? JSONDecoder().decode([TMTPlayerItem].self, from: data) else {
            call.reject("Unable to parse string json to media item")
            return
        }
        
        //  Save the call. Doc: https://capacitorjs.com/docs/core-apis/saving-calls
        call.keepAlive = true
        
        //  Start playing media list
        
        TMTPlayer.shared.startPlayingMediaList(
            mediaList,
            mediaItemDidEndPlayingSuccess: { item in
                //  handle avplayer did finish playing
                call.resolve([
                    "playerDidFinishPlayingItem": item.url
                ])
        })
    }

    @objc public func addMediaToList(_ call: CAPPluginCall) {
        
        guard let mediaListString = call.getString("mediaList") else {
            call.reject("mediaList key-value is missing in request")
            return
        }
        guard let data = mediaListString.data(using: .utf8) else {
            call.reject("Unable to convert string to data")
            return
        }
        guard let mediaList = try? JSONDecoder().decode([TMTPlayerItem].self, from: data) else {
            call.reject("Unable to parse string json to media item")
            return
        }
        
        TMTPlayer.shared.addMediaToList(mediaList)
    }

    @objc func clearMediaList(_ call: CAPPluginCall) {
        
        TMTPlayer.shared.clearMediaList()
    }

    @objc public func play(_ call: CAPPluginCall) {
        
        let isPlaying = TMTPlayer.shared.play()
        call.resolve([
            "playerPlayed": isPlaying ? "true" : "false"
        ])
    }
    
    @objc public func pause(_ call: CAPPluginCall) {
        
        TMTPlayer.shared.pause()
        call.resolve([
            "playerPaused": "true"
        ])
    }
    
    @objc public func getCurrentPlayerItemSeekTime(_ call: CAPPluginCall) {
        
        let currentTimeInSeconds = TMTPlayer.shared.getCurrentPlayerItemSeekTime()
        call.resolve([
            "currentTimeInSeconds": "\(currentTimeInSeconds)"
        ])
    }
    
    @objc public func fetchMediaListStatistics(_ call: CAPPluginCall) {
        
        let statisticsList = TMTPlayer.shared.fetchMediaListStatistics()
        call.resolve([
            "statisticsList": statisticsList
        ])
    }

    @objc public func updatePlayerRate(_ call: CAPPluginCall) {
        
        guard let rate = call.getFloat("rate") else {
            call.reject("rate (Float) key-value is missing in request")
            return
        }

        TMTPlayer.shared.updatePlayerRate(rate)
        call.resolve([
            "playerRateUpdated": "true"
        ])
    }
    
    @objc public func getCurrentMediaItemPlaybackInfo(_ call: CAPPluginCall) {
        
        let info = TMTPlayer.shared.getCurrentMediaItemPlaybackInfo()
        call.resolve([
            "currentMediaItemPlaybackInfo": info
        ])
    }
    
    @objc public func removeAllMediaItemsExceptCurrentPlayingItem(_ call: CAPPluginCall) {
        
        TMTPlayer.shared.removeAllMediaItemsExceptCurrentPlayingItem()
        call.resolve([
            "removeAllMediaItemsExceptCurrentPlayingItem": "true"
        ])
    }
    
    
    @objc public func seekToTimeInSeconds(_ call: CAPPluginCall) {
        
        guard let seconds = call.getDouble("seconds") else {
            call.reject("seconds (Double) key-value is missing in request")
            return
        }

        TMTPlayer.shared.seekToTimeInSeconds(seconds)
        call.resolve([
            "seekToTimeInSeconds": "true"
        ])
    }
    
    @objc public func checkPlayingMediaList(_ call: CAPPluginCall) {
        
        //  Save the call. Doc: https://capacitorjs.com/docs/core-apis/saving-calls
        call.keepAlive = true
        
        //  Start playing media list
        
        TMTPlayer.shared.checkPlayingMediaList(
            mediaItemDidEndPlayingSuccess: { item in
                //  handle avplayer did finish playing
                call.resolve([
                    "playerDidFinishPlayingItem": item.url
                ])
        })
    }
}
