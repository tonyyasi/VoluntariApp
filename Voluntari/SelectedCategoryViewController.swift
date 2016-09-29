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
        
        view.backgroundColor = .white
        navigationItem.title = selectedCategory?.capitalized
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        let bg = UIView()
        bg.backgroundColor = .white
        tableView.backgroundView = bg


        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProyectViewController
            vc.chosenProyect = self.chosenOne
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosen.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.chosenOne = chosen[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "catToProy", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "proyectos") as! InterestingCell
        cell.topLabel.text = chosen[(indexPath as NSIndexPath).row].name
        cell.bottomLabel.text = chosen[(indexPath as NSIndexPath).row].place

        cell.contentView.backgroundColor = ColorPalette.background
        return cell
    }
    
}
