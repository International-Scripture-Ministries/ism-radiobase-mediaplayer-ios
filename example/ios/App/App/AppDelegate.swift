import UIKit
import Capacitor
import Tmtplayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var plugin: TMTPlayerPlugin?
    private var isPlaying = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.testPlugin()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                return
            }
            let call = CAPPluginCall.init(callbackId: "0", options: ["rate": 2.0]) { result, call in
                print(result)
                print(call)
            } error: { error in
                print(error)
            }
            self.plugin?.updatePlayerRate(call!)
        }
        
        //  get statistics of last played media before app close
        
//        let callToRemoveSavedStatistics = CAPPluginCall.init(callbackId: "0", options: [:]) { result, call in
//            print(result?.resultData)
//            print(call)
//        } error: { error in
//            print(error)
//        }
//        self.plugin?.removeStatisticsOfLastPlayedMedia(callToRemoveSavedStatistics!)

        
        let call = CAPPluginCall.init(callbackId: "0", options: [:]) { result, call in
            print(result?.resultData)
            print(call)
        } error: { error in
            print(error)
        }
        self.plugin?.getStatisticsOfLastPlayedMediaBeforeAppClose(call!)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
//        let JSON = """
//        [
//          {
//            "url": "https://teachings-cdn.thruthebible.io/1167999d-a3db-44a4-b1dd-6ef0a9645186",
//            "title": "title 2",
//            "artist": "artist 2",
//            "image": "",
//            "duration": "15",
//            "isStreaming": false,
//            "isPlaying": false,
//            "isStudy": true,
//            "playbackPositionInSeconds": 0
//          }
//        ]
//        """
//        
//        let call = CAPPluginCall.init(callbackId: "22", options: ["mediaList": JSON]) { _, _ in } error: { _ in }
//        self.plugin?.addMediaToList(call!)

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        let call = CAPPluginCall.init(callbackId: "0", options: ["rate": 2.0]) { result, call in
            print(result?.resultData)
            print(call)
        } error: { error in
            print(error)
        }
        
        if self.isPlaying {
            self.plugin?.pause(call!)
        } else {
            self.plugin?.play(call!)
        }
        self.isPlaying.toggle()
        
//        self.plugin?.fetchMediaListStatistics(call!)

//
////        self.plugin?.getCurrentPlayerItemSeekTime(call!)
//        self.plugin?.fetchMediaListStatistics(call!)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // Called when the app was launched with a url. Feel free to add additional processing here,
        // but if you want the App API to support tracking app url opens, make sure to keep this call
        return ApplicationDelegateProxy.shared.application(app, open: url, options: options)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Called when the app was launched with an activity, including Universal Links.
        // Feel free to add additional processing here, but if you want the App API to support
        // tracking app url opens, make sure to keep this call
        return ApplicationDelegateProxy.shared.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

}

private extension AppDelegate {
    
    func testPlugin() {
        
        let JSON = """
        [
          {
            "url": "https://teachings-cdn.thruthebible.io/2e9ca06c-0246-45f3-8179-1989f715903e",
            "title": "title 1",
            "artist": "artist 1",
            "image": "",
            "duration": "10",
            "isStreaming": false,
            "isPlaying": false,
            "isStudy": true,
            "playbackPositionInSeconds": 10.0
          },
          {
            "url": "https://teachings-cdn.thruthebible.io/1167999d-a3db-44a4-b1dd-6ef0a9645186",
            "title": "title 2",
            "artist": "artist 2",
            "image": "",
            "duration": "15",
            "isStreaming": false,
            "isPlaying": false,
            "isStudy": true,
            "playbackPositionInSeconds": 0
          }
        ]
        """
        
        let call = CAPPluginCall.init(callbackId: "1", options: ["mediaList": JSON]) { _, _ in } error: { _ in }
        self.plugin = TMTPlayerPlugin()
        self.plugin?.playMediaList(call!)
    }
}
