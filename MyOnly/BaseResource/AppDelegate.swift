//
//  AppDelegate.swift
//  MyOnly
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 macZh. All rights reserved.
//

import UIKit
import CoreData
import GDPerformanceView_Swift
import XCGLogger

let appDelegate = UIApplication.shared.delegate as! AppDelegate

let HHLog: XCGLogger = {
    let HHLog = XCGLogger(identifier: "HHLogger🙄🙄", includeDefaultDestinations: false)
    
    let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.appleSystemLogDestination")
    
    // Optionally set some configuration options
    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = true
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    // Add the destination to the logger
    HHLog.add(destination: systemDestination)
    
    let logPath: URL = appDelegate.cacheDirectory.appendingPathComponent("XCGLogger_Log.txt")
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = " YYYY - MM - dd HH:mm:ss"
    let autoRotatingFileDestination = AutoRotatingFileDestination(owner: HHLog, writeToFile: logPath, identifier: "HHLogger🙄🙄", shouldAppend: true, appendMarker: "60", maxFileSize: 1024 * 5, archiveSuffixDateFormatter: dateformatter)
    
    // Optionally set some configuration options
    autoRotatingFileDestination.outputLevel = .debug
    autoRotatingFileDestination.showLogIdentifier = false
    autoRotatingFileDestination.showFunctionName = true
    autoRotatingFileDestination.showThreadName = true
    autoRotatingFileDestination.showLevel = true
    autoRotatingFileDestination.showFileName = true
    autoRotatingFileDestination.showLineNumber = true
    autoRotatingFileDestination.showDate = true
    autoRotatingFileDestination.targetMaxLogFiles = 10 // probably good for this demo and production, (default is 10, max is 255)
    
    // Process this destination in the background
    autoRotatingFileDestination.logQueue = XCGLogger.logQueue
    
    // Add colour (using the ANSI format) to our file log, you can see the colour when `cat`ing or `tail`ing the file in Terminal on macOS
    let ansiColorLogFormatter: ANSIColorLogFormatter = ANSIColorLogFormatter()
    ansiColorLogFormatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
    ansiColorLogFormatter.colorize(level: .debug, with: .black)
    ansiColorLogFormatter.colorize(level: .info, with: .blue, options: [.underline])
    ansiColorLogFormatter.colorize(level: .warning, with: .red, options: [.faint])
    ansiColorLogFormatter.colorize(level: .error, with: .red, options: [.bold])
    ansiColorLogFormatter.colorize(level: .severe, with: .white, on: .red)
    autoRotatingFileDestination.formatters = [ansiColorLogFormatter]
    
    // Add the destination to the logger
    HHLog.add(destination: autoRotatingFileDestination)
    
    // Add basic app info, version info etc, to the start of the logs
    HHLog.logAppDetails()

    // You can also change the labels for each log level, most useful for alternate languages, French, German etc, but Emoji's are more fun
    HHLog.levelDescriptions[.verbose] = "🗯"
    HHLog.levelDescriptions[.debug] = "🔹"
    HHLog.levelDescriptions[.info] = "ℹ️"
    HHLog.levelDescriptions[.warning] = "⚠️"
    HHLog.levelDescriptions[.error] = "‼️"
    HHLog.levelDescriptions[.severe] = "💣"

    // Alternatively, you can use emoji to highlight log levels (you probably just want to use one of these methods at a time).
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
    emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
    emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
    emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
    emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
    emojiLogFormatter.apply(prefix: "💣💣💣 ", postfix: " 💣💣💣", to: .severe)
    HHLog.formatters = [emojiLogFormatter]
    
    return HHLog
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    var performanceView: GDPerformanceMonitor?
    
    let documentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window? = UIWindow.init(frame: UIScreen.main.bounds)
        let tabbarvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as! UITabBarController
        tabbarvc.delegate = self
        self.window?.rootViewController = UINavigationController.init(rootViewController: tabbarvc)
        self.window?.makeKeyAndVisible()
        
        #if DEBUG
            GDPerformanceMonitor.sharedInstance.startMonitoring()
            GDPerformanceMonitor.sharedInstance.configure(configuration: { (textLabel) in
                textLabel?.backgroundColor = .black
                textLabel?.textColor = .white
                textLabel?.layer.borderColor = UIColor.black.cgColor
            })
        #endif
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MyOnly")
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

    // MARK: - Core Data Saving support

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

