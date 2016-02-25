//
//  ViewController.swift
//  MyVideoBlog
//
//  Created by Juan Antonio Martin Noguera on 15/02/16.
//  Copyright © 2016 Cloud On Mobile S.L. All rights reserved.
//

import UIKit

import AWSCore
import AWSCognito

class ViewController: UIViewController {

    
    var creditialsProvider : AWSCognitoCredentialsProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startSessionInAWS()
        
        // chequear el token del usuario de FB
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "profileUserData:",
            name: FBSDKProfileDidChangeNotification,
            object: nil)
        
        
        // vamos a chequear que tenemos algun token valido de Facebook
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            
            print("Tenemos ya un toke y por lo tanto estamos autenticados \(FBSDKAccessToken.currentAccessToken().userID)")
            
            let token = FBSDKAccessToken.currentAccessToken().tokenString
            
            
            creditialsProvider?.logins = [ AWSCognitoLoginProviderKey.Facebook.rawValue : token]
            syncWithCognitoInfoUser()
            
        } else {
            
            let login = FBSDKLoginManager()
            
            login.logInWithPublishPermissions(["public_profile"],
                fromViewController: self,
                handler: { ( result: FBSDKLoginManagerLoginResult!, error : NSError!) -> Void in
                
                    if error != nil{
                        print("Error")
                    } else {
                        if (result.isCancelled == false){
                            self.syncWithCognitoInfoUser()
                        } else {
                            print("El usuario ha denegado el registro")
                        }
                    }
            })
            
        }
        
    }
    
    
    func syncWithCognitoInfoUser(){
        
        let tokenCurrentUser = FBSDKAccessToken.currentAccessToken().tokenString
        
        let clientSync = AWSCognito.defaultCognito()
        
        
        let dataSet = clientSync.openOrCreateDataset("UsersLogged")
        dataSet.setString(tokenCurrentUser, forKey: "token")
        dataSet.setString(FBSDKAccessToken.currentAccessToken().userID, forKey: "userFacebookID")
        dataSet.setString(FBSDKProfile.currentProfile().name, forKey: "userName")
        
        // sincronizar este dataSet en Cognito
        
        dataSet.synchronize().continueWithBlock { (task : AWSTask) -> AnyObject? in
            
            if task.error != nil {
                print("tarea completada")
            }
            return nil
        }

    }
    
    func profileUserData (notication : NSNotification){
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func logarseEnRedSocial(sender: AnyObject) {
        
        
        
        
    }
    
    
    // MARK - Iniciar sesion en AWS
    
    func startSessionInAWS () {
        
        creditialsProvider = AWSCognitoCredentialsProvider(regionType: .EUWest1,
            identityPoolId: "eu-west-1:f2ebf247-20b9-4d34-9b32-906290dbe0c3")
        
        let configuration = AWSServiceConfiguration(region: .EUWest1, credentialsProvider: creditialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        
        
        print("El creditial ID actual es ---> \(creditialsProvider!.identityId) \(creditialsProvider!.identityProvider) \(creditialsProvider!.identityPoolId)")
        
        
        
//        let syncClient = AWSCognito.defaultCognito()
        
    }
    
    
    
    
    
    
 
    
}

