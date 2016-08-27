//
//  ViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    let user = User()
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
            
          
            self.user.initialize(result)
            self.sendUserToViews()
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
    
    func sendUserToViews(){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("info") as! InfoViewController
        let vc2 = storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        let vc3 = storyboard?.instantiateViewControllerWithIdentifier("categories") as! CategoriesViewController
        
        vc.user = self.user
        vc2.user = self.user
        vc3.user = self.user
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

