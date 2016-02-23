//
//  DetailPostController.swift
//  MyVideoBlog
//
//  Created by Juan Antonio Martin Noguera on 23/02/16.
//  Copyright © 2016 Cloud On Mobile S.L. All rights reserved.
//

import UIKit

import MediaPlayer
import MobileCoreServices

class DetailPostController: UIViewController {


    var record : AnyObject?
    
    @IBOutlet weak var webView : UIWebView!
    @IBOutlet weak var titulo : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(record)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showBlob (sender: AnyObject){
        
    }


}

extension UINavigationControllerDelegate {
    
}
