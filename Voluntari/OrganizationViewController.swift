//
//  OrganizationViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/28/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class OrganizationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
        @IBOutlet weak var tableView: UITableView!
    var chosenProj = Project()
    var org = Organization()
    var index = 0
    
    @IBOutlet weak var orgName: UILabel!
    
   
    @IBOutlet weak var descriptionLabel: UILabel!
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        let bg = UIView()
        bg.backgroundColor = .white
        tableView.backgroundView = bg
        orgName.text = org.name
        descriptionLabel.text = "Description: \((org.description)!)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cel") as! InterestingCell
        cell.topLabel.text = org.projects[(indexPath as NSIndexPath).row].name
        cell.bottomLabel.text = org.projects[(indexPath as NSIndexPath).row].place
        cell.contentView.backgroundColor = .white
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProyectViewController
        vc.chosenProyect = org.projects[index]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "se", sender: nil)
        index = (indexPath as NSIndexPath).row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return org.projects.count
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
