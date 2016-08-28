//
//  SelectedCategoryViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/28/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class SelectedCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCategory: String?
    var chosen:[Project] = []
    var chosenOne = Project()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = selectedCategory
        view.backgroundColor = ColorPalette.background
        navigationItem.title = selectedCategory
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        let bg = UIView()
        bg.backgroundColor = ColorPalette.background
        tableView.backgroundView = bg


        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ProyectViewController
            vc.chosenProyect = self.chosenOne
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosen.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.chosenOne = chosen[indexPath.row]
        performSegueWithIdentifier("catToProy", sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("proyectos") as! InterestingCell
        cell.topLabel.text = chosen[indexPath.row].name
        cell.bottomLabel.text = chosen[indexPath.row].place

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
