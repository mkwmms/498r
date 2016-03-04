//
//  FBLoginViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/3/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    let fBAdapter = FBAdapter()
    @IBOutlet weak var fbProfilePicture: UIImageView!
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["user_photos","user_posts"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        if let _ = FBSDKAccessToken.currentAccessToken() {
            //fetchProfile()
            fBAdapter.retrieveMetaData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchProfile() {
        /*
        let parameters = ["fields": "picture.type(large),photos.type(uploaded){images, created_time}"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler {( connection, result, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            
            let resultImages = result.objectForKey("photos")!.objectForKey("data")!
            print ("resultImagesCount:", resultImages.count)
            print (resultImages)
            for (var i = 0; i < resultImages.count; i++) {
                
                let fbImageMetaData = resultImages[i].objectForKey("images")![0].objectForKey("source")
                
                let fbImageCreationDate = resultImages[i].objectForKey("created_time")!
                
                print("metadata:", fbImageMetaData!)
                print("creationDate:", fbImageCreationDate)
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let date = dateFormatter.dateFromString(fbImageCreationDate as! String)
                
                let memorable = FBMemorable(creationDate: date!, data: fbImageMetaData!)
                
                
//                print("FBImageMetaData:", fbImageMetaData)
                //                let memorable = FBMemorable(creationDate: <#T##NSDate#>, data: <#T##Any#>))
                
                //                let time = fbImageMetaData.objectForKey("created_time")
            }
            
            let url = NSURL(string: (result.objectForKey("photos")!.objectForKey("data")![0].objectForKey("images")![0]!.objectForKey("source") as! String))
            
            let imageDataFromURL = NSData(contentsOfURL: url!)
            
            let fbImage = UIImage(data: imageDataFromURL!)
        }
        */
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("completed login")
        fetchProfile()
        performSegueWithIdentifier("LoginToMonthViewController", sender: nil)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {

    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
