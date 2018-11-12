//
//  AppDelegate.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/27/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    // We ask for permission to send notifications, first
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = UserDefaults.standard
        if !hasAppAlreadyLaunchedOnce() {
            defaults.set(2, forKey: "lowestPriorityFrequency")
            defaults.set("Weeks", forKey: "lowestPriorityUnits")
            
            defaults.set(1, forKey: "mediumPriorityFrequency")
            defaults.set("Weeks", forKey: "mediumPriorityUnits")
            
            defaults.set(1, forKey: "highPriorityFrequency")
            defaults.set("Days", forKey: "highPriorityUnits")
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (authorized : Bool, error) in
            
        }
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    
    // This function asks what to do if the notification appears when app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    // This function asks what to do when a certain response on a notification is given, like when a custom action button is clicked
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    func hasAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        let appKey = "AppAlreadyLaunched"
        if defaults.string(forKey: appKey) != nil {
            return true
        } else {
            defaults.set("HEhe launched once sir", forKey: appKey)
            return false
        }
        
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
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

