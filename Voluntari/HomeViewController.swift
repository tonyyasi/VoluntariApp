//
//  HomeViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var projects: [Project] = []
    
    @IBOutlet weak var homeTableView: UITableView!
    var user = User()
    var index = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiClient.sharedApiClient.fetchProjects { (proj) in
            self.projects = proj
            self.homeTableView.reloadData()
        }
      
        let logOutButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeViewController.logOut))

        navigationItem.rightBarButtonItem = logOutButton
        
        // b9e4f0
        view.backgroundColor = ColorPalette.background
        homeTableView.delegate = self
        homeTableView.dataSource = self
        let bg = UIView()
        bg.backgroundColor = ColorPalette.background
        homeTableView.backgroundView = bg
        self.navigationItem.title = "Home"
        
        if(user.firstName == nil){
            fetchProfile()
        }
        

        // Do any additional setup after loading the view.
    }
    
    func fetchProfile(){
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            if error != nil{
                print(error)
                return
            }
            
            
            self.user.initialize(result)
            let viewC = self.storyboard?.instantiateViewControllerWithIdentifier("first") as! ViewController
            viewC.sendUserToViews()
            
        }
    }

    
    func logOut(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let vc = storyboard?.instantiateViewControllerWithIdentifier("first")
        presentViewController(vc!, animated: false, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ProyectViewController
        vc.chosenProyect = self.projects[index]
       
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.index = indexPath.row
         performSegueWithIdentifier("choseProyect", sender: nil)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("proyectos") as! InterestingCell
        cell.topLabel.text = projects[indexPath.row].name
        cell.bottomLabel.text = projects[indexPath.row].place
        cell.contentView.backgroundColor = ColorPalette.background
        
        return cell
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
