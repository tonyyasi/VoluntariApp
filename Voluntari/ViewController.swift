//
//  ViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    /*!
     @abstract Sent to the delegate when the button was used to login.
     @param loginButton the sender
     @param result The results of the login
     @param error The error (if any) from the login
     */
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
            fetchProfile()
            nextView()
        
        
    }

    let user = User()
    let FBButton: FBSDKLoginButton = {
       let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile" , "user_likes", "email"]
        return button
    }()
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        
        let token = FBSDKAccessToken.current()
        if  token != nil {
            fetchProfile()
            self.nextView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(FBButton)
        FBButton.delegate = self
        FBButton.center = view.center
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchProfile(){
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil{
                print(error)
                return
            }
            
          
            self.user.initialize(result as AnyObject)
            self.sendUserToViews()
        }
    }
    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        if(!(result.isCancelled)){
//        fetchProfile()
//        nextView()
//        }
//        
//        
//        
//    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func nextView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "tab")
        present(vc!, animated: true, completion: nil)
    }
    
    func sendUserToViews(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "info") as! InfoViewController
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "categories") as! CategoriesViewController
        
        vc.user = self.user
        vc2.user = self.user
        vc3.user = self.user
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

