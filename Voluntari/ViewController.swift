//
//  ViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let FBButton: FBSDKLoginButton = {
       let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile" , "user_likes", "email"]
        return button
    }()
    
    override func viewDidAppear(animated: Bool) {
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
            self.nextView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(FBButton)
        FBButton.delegate = self
        FBButton.center = view.center
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchProfile(){
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            if error != nil{
                print(error)
                return
            }
            
            if let email = result["email"] as? String {
                print(email)
            }
            
            
            if let name = result["first_name"] as? String {
                print(name)
            }
            
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        fetchProfile()
        nextView()
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func nextView(){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("nav")
        presentViewController(vc!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

