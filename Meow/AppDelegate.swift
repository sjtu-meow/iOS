//
//  AppDelegate.swift
//  Meow
//
//  Created by 林武威 on 2017/6/26.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import AVOSCloud
import ChatKit
import Keys
import RxSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        
        let keys = MeowKeys()
        
        Bugly.start(withAppId: keys.buglyAppId)
        
        login()
        
        // Initialize Leancloud
        AVOSCloud.setApplicationId(keys.leanCloudAppId, clientKey: keys.leanCloudClientKey)
        LCChatKit.setAppId(keys.leanCloudAppId, appKey:keys.leanCloudClientKey)
        ChatManager.didFinishLaunching()
        
        // Init ShareSDK
        ShareSDK.registerActivePlatforms(
            [
                SSDKPlatformType.typeSMS.rawValue,
                SSDKPlatformType.typeMail.rawValue,
                SSDKPlatformType.typeCopy.rawValue
                //SSDKPlatformType.typeQQ.rawValue,
                //SSDKPlatformType.typeWechat.rawValue,
                //SSDKPlatformType.typeEvernote.rawValue
            ],
            onImport: { (platform : SSDKPlatformType) -> Void in
                                            // do nothing
            },
            onConfiguration: { (platform : SSDKPlatformType , appInfo : NSMutableDictionary?) -> Void in
                                             // do nothing
            }
        )
    
        QiniuProvider.shared.checkToken()
        
        /* login page */
      
        if Token.load() == nil {
            let vc = R.storyboard.loginSignupPage.loginSignupController()!
            vc.modalPresentationStyle = .fullScreen
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        ChatManager.applicationWillResignActive(application: application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        ChatManager.applicationWillTerminate(application: application)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        ChatManager.application(application, didReceiveRemoteNotification: userInfo)
    }
    
    func login() {
        UserManager.shared.login(phone: "13333333333", password: "meow233")
    }

}

