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
        CAPPluginMethod(name: "play", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pause", returnType: CAPPluginReturnPromise)
    ]
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": "echo called"
        ])
    }
    
    @objc func play(_ call: CAPPluginCall) {
        
        guard let mediaUrlString = call.getString("url") else {
            call.reject("url key-value is missing in request")
        }
        
        //  Save the call. Doc: https://capacitorjs.com/docs/core-apis/saving-calls
        call.keepAlive = true
        
        //  Play the item
        let tmpPlayerItem = TMTPlayerItem(
            url: mediaUrlString,
            title: call.getString("title") ?? ""
        )
        
        TMTPlayer.shared.play(item: tmpPlayerItem) { [weak self] in
            //  handle avplayer did finish playing
            call.resolve([
                "playerDidFinishPlayingItem": mediaUrlString
            ])
        }
    }
    
    @objc func pause(_ call: CAPPluginCall) {
        
        TMTPlayer.shared.pause()
        
        call.resolve([
            "playerPaused": "true"
        ])
    }
}
