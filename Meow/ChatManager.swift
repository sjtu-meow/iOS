//
//  ChatManager.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation

import ChatKit
import RxSwift


class ChatManager {
    
    open class func didFinishLaunching() {
    // 如果APP是在国外使用，开启北美节点
    // 必须在 APPID 初始化之前调用，否则走的是中国节点。
    // [AVOSCloud setServiceRegion:AVServiceRegionUS];
    // 启用未读消息
        AVIMClient.setUserOptions([AVIMUserOptionUseUnread:true])
        AVIMClient.setTimeoutIntervalInSeconds(20)
    //添加输入框底部插件，如需更换图标标题，可子类化，然后调用 `+registerSubclass`
        LCCKInputViewPluginTakePhoto.registerSubclass()
        LCCKInputViewPluginPickImage.registerSubclass()
        LCCKInputViewPluginLocation.registerSubclass()
        
        LCChatKit.sharedInstance().fetchProfilesBlock = {
            userIds, completionHandler in
            if (userIds!.count == 0) {
                let error = NSError()
                
                Observable.from(userIds!).concatMap({ userId in
                    return MeowAPIProvider.shared.request(.herProfile(id: Int(userId)!))
                })
                .map({ profile in
                    return ChatKitUser.from(profile: profile as! Profile)
                })
                .reduce([ChatKitUser]()) {(users, user)in
                        var mutableUsers = users!
                        mutableUsers.append(user)
                        return mutableUsers
                }
                .subscribeOn(CurrentThreadScheduler.instance)
                .subscribe(onNext: {
                    users in
                    completionHandler?(users, nil)
                })

                completionHandler?(nil, error)
            }
            
        
        }
    }
    
    
    open class func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {
        AVOSCloud.handleRemoteNotifications(withDeviceToken: deviceToken)
    }
        
    open class func willLogoutSuccess() {
        AVOSCloudIM.handleRemoteNotifications(withDeviceToken: Data())
        LCChatKit.sharedInstance().removeAllCachedProfiles()
        LCChatKit.sharedInstance().close(callback: { succeeded, error in
            // do nothing
        })
    }
            
    open class func didLoginSuccess(withClientId clientId: String) {
                //success:(LCCKVoidBlock)success
                //failed:(LCCKErrorBlock)failed {
                // [[self sharedInstance] exampleInit];
        LCChatKit.sharedInstance().open(withClientId: clientId) {
            succeeded, error in
            if(succeeded) {
                logger.log("ChatKit login successfully")
            } else {
                logger.log(error!.localizedDescription)
            }
        }
    }
    
    open class func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any])  {
        if (application.applicationState == UIApplicationState.active) {
        // 应用在前台时收到推送，只能来自于普通的推送，而非离线消息推送
        } else {
        /*!
         *  当使用 https://github.com/leancloud/leanchat-cloudcode 云代码更改推送内容的时候
         {
         aps = {
         alert = "lcckkit : sdfsdf";
         badge = 4;
         sound = default;
         };
         convid = 55bae86300b0efdcbe3e742e;
         }
         */
        LCChatKit.sharedInstance().didReceiveRemoteNotification(userInfo)
        }
    }
    
    open class func applicationWillResignActive(application:UIApplication) {
        LCChatKit.sharedInstance().syncBadge()
    }
        
    open class func applicationWillTerminate(application: UIApplication) {
        LCChatKit.sharedInstance().syncBadge()
    }
    
    
    
    /**
     *  打开单聊页面
     */
    open class func openConversationViewController(withPeerId peerId: String,
    from navigationController:UINavigationController) {
        guard let currentUser = UserManager.shared.currentUser else { return }
        guard currentUser.userId != Int(peerId) else { return }
        
        let vc = LCCKConversationViewController(peerId: peerId)!
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    

    open class func openConversationViewController(
        conversaionId: String,
        fromNavigationController navigationController:
        UINavigationController)  {
        let vc = LCCKConversationViewController(conversationId: conversaionId)!
        vc.isEnableAutoJoin = true
        vc.hidesBottomBarWhenPushed = true 
            
        navigationController.pushViewController(vc, animated: true)
     }

    
  
}


