//
//  ProyectViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class ProyectViewController: UIViewController {
    
    
    @IBAction func clickedOnOrg(sender: AnyObject) {
        performSegueWithIdentifier("segue", sender: nil)
        
    }
    
    @IBAction func donateButtonPressed(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var organizationButton: UIButton!
    
    @IBOutlet weak var inscribirseButton: UIButton!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    var chosenProyect: Project?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.background
        remainingLabel.text = " Solo quedan \(chosenProyect!.freeSpaces) lugares"
        descriptionLabel.text = chosenProyect!.description
        projectTitleLabel.text = chosenProyect!.name
        timeLabel.text = chosenProyect?.date
        placeLabel.text = chosenProyect?.place
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
