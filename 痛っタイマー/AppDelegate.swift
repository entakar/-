//
//  AppDelegate.swift
//  痛っタイマー
//
//  Created by EndoTakashi on 2016/05/09.
//  Copyright © 2016年 tak. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITableViewDelegate,
    UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var viewController: ViewController!
    var times = NSTimer()
    var backgroundTaskID: UIBackgroundTaskIdentifier = 0
    var backCount:Int = 0
    var backFlagback    = 0
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //ローカルノティフィケーションの利用許可の取得(4)
        application.registerUserNotificationSettings(UIUserNotificationSettings(
            forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert],
            categories: nil))
        
        // Override point for customization after application launch.
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        //application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        /// バックグラウンドでも再生できるカテゴリに設定する
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch  {
            // エラー処理
            fatalError("カテゴリ設定失敗")
        }
        
        // sessionのアクティブ化
        do {
            try session.setActive(true)
        } catch {
            // audio session有効化失敗時の処理
            // (ここではエラーとして停止している）
            fatalError("session有効化失敗")
        }
        return true
    }

    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    //バックグラウンド遷移移行直前に呼ばれる
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print ("バックグラウンド")
        self.backgroundTaskID = application.beginBackgroundTaskWithExpirationHandler(){
            [weak self] in
            application.endBackgroundTask((self?.backgroundTaskID)!)
            self?.backgroundTaskID = UIBackgroundTaskInvalid
        }
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    func backstep(){
        
    }
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    }

    //アプリがアクティブになる度に呼ばれる
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        application.endBackgroundTask(self.backgroundTaskID)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

