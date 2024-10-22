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
        CAPPluginMethod(name: "fetchMediaListStatistics", returnType: CAPPluginReturnPromise)
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

    @objc func addMediaToList(_ call: CAPPluginCall) {
        
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

    @objc func play(_ call: CAPPluginCall) {
        
        let isPlaying = TMTPlayer.shared.play()
        call.resolve([
            "playerPlayed": isPlaying ? "true" : "false"
        ])
    }
    
    @objc func pause(_ call: CAPPluginCall) {
        
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
}

