//
//  AppDelegate.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/27/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    // We ask for permission to send notifications, first
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup Window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        window?.rootViewController = TabBarController()
        
        
//
//        let defaults = UserDefaults.standard
//        if !hasAppAlreadyLaunchedOnce() {
//            defaults.set(2, forKey: "lowestPriorityFrequency")
//            defaults.set("Weeks", forKey: "lowestPriorityUnits")
//
//            defaults.set(1, forKey: "mediumPriorityFrequency")
//            defaults.set("Weeks", forKey: "mediumPriorityUnits")
//
//            defaults.set(1, forKey: "highPriorityFrequency")
//            defaults.set("Days", forKey: "highPriorityUnits")
//        }
//
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (authorized : Bool, error) in
//
//        }
//
//        UNUserNotificationCenter.current().delegate = self
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
        self.saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "PriorityReminders")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // Static version of persistentContainer to allow this syntax
    // let coreDataContainer = AppDelegate.persistentContainer
    static var persistentContainer: NSPersistentContainer = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }()
    
    // Access the context for core data like this
    // let context = AppDelegate.viewContext
    // Note: Only returns context for the specified persistent container above.
    static var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    
    // MARK: - Core Data Saving support
    // Only saves the context for the persistentContainer created above
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

