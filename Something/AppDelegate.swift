//
//  AppDelegate.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-11.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func purgeCoreData(){
        purge(entityName: "Thing")
        purge(entityName: "Time")
        purge(entityName: "Kind")
        
    }
    
    
    func purge(entityName:String){
        let moc = persistentContainer.viewContext
        let venueFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName )
        do {
            let fetched = try moc.fetch(venueFetch) as! [NSManagedObject]
            fetched.forEach({moc.delete($0)})
            
        } catch {
            print("Something went wrong.\n")
        }
        saveContext()
        
    }
    func setupCoreData(){
        setupKinds()
        setupTimes()
    }
    func newKind(id:Int64, alpha:Int64,color:Int64, title:String){
        let kind = NSEntityDescription.insertNewObject(forEntityName: "Kind", into: persistentContainer.viewContext) as! Kind
        kind.id = id
        kind.alpha = alpha
        kind.color = color
        kind.title = title
        saveContext()
    }
    func setupKinds(){
        newKind(id: 1,alpha: 1,color: 0xff0000,title: "need to do")
        newKind(id: 2,alpha: 1,color: 0xff0000,title: "nice to do")
        newKind(id: 3,alpha: 1,color: 0xff0000,title: "want to do")
        
    }
    func newTime(id:Int64, alpha:Int64,color:Int64, title:String){
        let time = NSEntityDescription.insertNewObject(forEntityName: "Time", into: persistentContainer.viewContext) as! Time
        time.id = id
        time.alpha = alpha
        time.color = color
        time.title = title
        saveContext()
    }
    func setupTimes(){
        newTime(id: 1,alpha: 1, color: 0xff0000, title: "5min")
        newTime(id: 2,alpha: 1, color: 0xff0000, title: "30min")
        newTime(id: 3,alpha: 1, color: 0xff0000, title: "60min")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        purgeCoreData()
        setupCoreData()
        
        
        
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
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
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
        let container = NSPersistentContainer(name: "Something")
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
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
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

