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
      
        let logOutButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeViewController.logOut))

        navigationItem.rightBarButtonItem = logOutButton
        
        // b9e4f0
        view.backgroundColor = .white
        homeTableView.delegate = self
        homeTableView.dataSource = self
        let bg = UIView()
        bg.backgroundColor = .white
        homeTableView.backgroundView = bg
        self.navigationItem.title = "Home"
        
        if(user.firstName == nil){
            fetchProfile()
        }
        

        // Do any additional setup after loading the view.
    }
    
    func fetchProfile(){
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil{
                print(error)
                return
            }
            
            
            self.user.initialize(result as AnyObject)
            let viewC = self.storyboard?.instantiateViewController(withIdentifier: "first") as! ViewController
            viewC.sendUserToViews()
            
        }
    }

    
    func logOut(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let vc = storyboard?.instantiateViewController(withIdentifier: "first")
        present(vc!, animated: false, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProyectViewController
        vc.chosenProyect = self.projects[index]
       
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.index = (indexPath as NSIndexPath).row
         performSegue(withIdentifier: "choseProyect", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proyectos") as! InterestingCell
        cell.topLabel.text = projects[(indexPath as NSIndexPath).row].name
        cell.bottomLabel.text = projects[(indexPath as NSIndexPath).row].place
        cell.contentView.backgroundColor = .white
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
