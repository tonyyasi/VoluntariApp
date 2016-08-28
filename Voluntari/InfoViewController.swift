//
//  InfoViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var user = User()
    
    
    @IBAction func linkToWeb(sender: AnyObject) {
        if let url = NSURL(string: "http://lideresdelmanana.itesm.mx/"){
        UIApplication.sharedApplication().openURL(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.background
        self.navigationItem.title = "Info"
        
        let logOutButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InfoViewController.logOut))
        
        navigationItem.rightBarButtonItem = logOutButton

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logOut(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let vc = storyboard?.instantiateViewControllerWithIdentifier("first")
        presentViewController(vc!, animated: false, completion: nil)
        
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
