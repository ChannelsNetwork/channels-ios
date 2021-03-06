//
//  AppDelegate.swift
//  channels
//
//  Created by Preet Shihn on 8/15/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var firstTime: Bool = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize OneSignal
        if !_Platform.isSumulator {
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            let onNotificationOpened: OSHandleNotificationActionBlock = { result in
                guard let payload = result?.notification.payload else {
                    return
                }
                let fullMessage = payload.body!
                print("Message: \(fullMessage)")
            }
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: "98b8d788-faff-4a91-a45c-f3fba0aef7c3",
                                            handleNotificationAction: onNotificationOpened,
                                            settings: onesignalInitSettings)
        }
        
        // Check if first time launch
        let defaults = UserDefaults.standard
        let launchedBefore = defaults.bool(forKey: "application-launched-before")
        firstTime = !launchedBefore
        if firstTime {
            defaults.set(true, forKey: "application-launched-before")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        guard ChannelService.instance.registration != nil else {
            return;
        }
        ChannelService.instance.getUserIdentity { (identityResponse: GetUserIdentityResponse?, _) in
            if let identity = identityResponse {
                if let handle = identity.handle {
                    if handle.characters.count > 0 {
                        let userIdentity = UserIdentity(address: IdentityManager.instance.userAddress, name: identity.name!, handle: identity.handle!, location: identity.location)
                        IdentityManager.instance.saveUserIdentity(userIdentity, callback: { (_) in })
                        return;
                    }
                }
            }
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

struct _Platform {
    static var isSumulator: Bool {
        get {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }
    }
}

