

import UIKit

import AWSCore
import AWSCognito



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    
        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
            // Activar el logger de AWS
            
            AWSLogger.defaultLogger().logLevel = .Verbose
            
            // Pasos minimos para chequear la validez del SDK de AWS
        
            let creditialsProvider = AWSCognitoCredentialsProvider(regionType: .EUWest1,
                identityPoolId: "eu-west-1:f2ebf247-20b9-4d34-9b32-906290dbe0c3")
            
            let configuration = AWSServiceConfiguration(region: .EUWest1, credentialsProvider: creditialsProvider)
            AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
            
        
            let syncClient = AWSCognito.defaultCognito()
            
            // Create a record in a dataset and synchronize with the server
            let dataset = syncClient.openOrCreateDataset("MisDatos")
            dataset.setString("myValue", forKey:"myKey")
            dataset.synchronize().continueWithBlock {(task: AWSTask!) -> AnyObject! in
                
                print("la paz en el mundo")
                
                return nil
                
            }

            
            
            let notificationSettings = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil )
            UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
        
        return true
    }


    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
                
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        let payload = userInfo as Dictionary
        print(payload)

        
    }
    
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//        code
//    }
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

