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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.background
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorPalette.background
        let bg = UIView()
        bg.backgroundColor = ColorPalette.background
        tableView.backgroundView = bg
        orgName.text = org.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cel") as! InterestingCell
        cell.topLabel.text = org.projects[indexPath.row].name
        cell.bottomLabel.text = org.projects[indexPath.row].place
        cell.contentView.backgroundColor = ColorPalette.background
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ProyectViewController
        vc.chosenProyect = org.projects[index]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("se", sender: nil)
        index = indexPath.row
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
