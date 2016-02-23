//
//  ViewPostController.swift
//  MyVideoBlog
//
//  Created by Juan Antonio Martin Noguera on 18/02/16.
//  Copyright © 2016 Cloud On Mobile S.L. All rights reserved.
//

import UIKit
import MobileCoreServices



class ViewPostController: UIViewController {

    @IBOutlet weak var saveInAzureButton: UIButton!
    @IBOutlet weak var validatorLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    
    var bufferVideo : NSData?
    var myBlobName : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Nuevo Post"
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "capturarVideo:")
        self.navigationItem.rightBarButtonItem = plusButton
        
        titleText.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveAzureAction(sender: AnyObject) {
        
    }
    
    func capturarVideo (sender : AnyObject){
        
        startCaptureVideoBlogFromViewController(self, withDelegate: self)
    }
    
    
    // MARK: - Metodos para la Captura de video
    
    func startCaptureVideoBlogFromViewController(viewcontroller: UIViewController, withDelegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool{
        
        if (UIImagePickerController.isSourceTypeAvailable(.Camera) == false) {
            
            return false
        }
        
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        
        return true
        
        
    }
    
    
        
    func uploadToStorage(data : NSData, blobName : String){

    }

}


extension ViewPostController: UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        let currentString = textField.text! as NSString
        
        if (currentString.length > 10) {
            validatorLabel.text = "Este titulo mola"
            validatorLabel.textColor = UIColor.greenColor()
            saveInAzureButton.enabled = true
        }
        
        
        return true
    }
}

extension ViewPostController: UINavigationControllerDelegate{
    
}

extension ViewPostController: UIImagePickerControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        dismissViewControllerAnimated(true, completion :nil)
        
        if (mediaType == kUTTypeMovie as String){
            
            let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path
            
            // tenemos que persistir en local - solo por aprender
            saveInDocuments(NSData(contentsOfURL: NSURL(fileURLWithPath: path!))!)
            
        }
        
    }
    
    
}

