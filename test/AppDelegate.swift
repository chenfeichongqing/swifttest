//
//  AppDelegate.swift
//  test
//
//  Created by 陈小爷 on 2016/10/19.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import OpenShare
let realm = try! Realm()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    var drawer:MMDrawerController!
    
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       //初始化融云sdk
        RCIM.shared().initWithAppKey("pvxdm17jxmanr")
        SMSSDK.registerApp("f3fc6baa9ac4", withSecret: "7f3dedcb36d92deebcb373af921d635a")
        OpenShare.connectQQ(withAppId: "1103194207")
        OpenShare.connectWeibo(withAppKey: "402180334")
        OpenShare.connectWeixin(withAppId: "wxd930ea5d5a258f4f")

        self.window=UIWindow.init()
     //初始化侧滑菜单
        drawer = MMDrawerController()
        let leftViewController = mySliderViewController()
        let centerViewController = ViewController()
        //    let centerNav = UINavigationController.init(rootViewController: centerViewController)
        // 设置左右控制器
        drawer = MMDrawerController.init(center: centerViewController, leftDrawerViewController: leftViewController, rightDrawerViewController: nil)
        // 侧拉距离
        drawer.maximumLeftDrawerWidth = 0.7 * KSCREEN.width
        // 手势
        drawer.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
        drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
        //设置动画，这里是设置打开侧栏透明度从0到1
        drawer.setDrawerVisualStateBlock { (drawerController, drawerSide, percentVisible) -> Void in
            
            var sideDrawerViewController:UIViewController?
            if(drawerSide == MMDrawerSide.left){
                sideDrawerViewController = drawerController?.leftDrawerViewController;
            }
            sideDrawerViewController?.view.alpha = percentVisible
        }
        
        if(!UserDefaults.standard.bool(forKey: "firstLaunch"))
         {
         
         let flashVC = SwiftIntroView()
        self.window?.rootViewController = flashVC
         UserDefaults.standard.set(true, forKey: "firstLaunch")
         UserDefaults.standard.synchronize()
         }
         else
         {
            let loginview = LoginView()
            self.window?.rootViewController = loginview
            UserDefaults.standard.set(false, forKey: "firstLaunch")
         }
 
        self.window?.makeKeyAndVisible()
        application.statusBarStyle=UIStatusBarStyle.lightContent
        application.isStatusBarHidden=false
        
        
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    // MARK: - Core Data stack
   
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.xiaoboswift.CoreDataDemo" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "test", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("test.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    //如果OpenShare能处理这个回调，就调用block中的方法，如果不能处理，就交给其他（比如支付宝）。
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if (OpenShare.handleOpen(url))
       {
            return true;
        }
        return true
    }
    
    //设置所有的屏幕为竖屏
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

