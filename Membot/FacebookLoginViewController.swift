//
//  FBLoginViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/3/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, FBSDKLoginButtonDelegate {

//    let fbAdapter = FBAdapter()
    @IBOutlet weak var fbProfilePicture: UIImageView!

    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["user_photos", "user_posts"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {

        if FBSDKAccessToken.currentAccessToken() != nil {
//            fbAdapter.retrieveMetaData()
            self.performSegueWithIdentifier("LoginToSettingsSegue", sender: self.loginButton)
        } else {
            view.addSubview(loginButton)
            loginButton.center = view.center
            loginButton.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        self.performSegueWithIdentifier("LoginToMonthViewController", sender: self)
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
//        self.performSegueWithIdentifier("LoginToMonthViewController", sender: self)
    }

    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
//        self.performSegueWithIdentifier("LoginToMonthViewController", sender: self)
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
