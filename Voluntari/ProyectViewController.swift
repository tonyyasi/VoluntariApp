//
//  ProyectViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class ProyectViewController: UIViewController {
    

    @IBAction func buttonclicked(_ sender: AnyObject) {
   print(inscribirseButton.currentTitle)
        if((inscribirseButton.currentTitle)! == "Inscribirse"){
            inscribirseButton.setTitle("Inscrito", for: UIControlState())
            inscribirseButton.tintColor = UIColor.red
            chosenProyect?.freeSpaces = (chosenProyect?.freeSpaces)! - 1
            remainingLabel.text = " Solo quedan \(chosenProyect!.freeSpaces) lugares"

        }

    }
    
    @IBAction func clickedOnOrg(_ sender: AnyObject) {
        performSegue(withIdentifier: "segue", sender: nil)
        
    }
    
    
    @IBOutlet weak var organizationButton: UIButton!
    
    @IBOutlet weak var inscribirseButton: UIButton!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    var chosenProyect: Project?
    var organization: Organization?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! OrganizationViewController
        vc.chosenProj = self.chosenProyect!
        vc.org = self.organization!
    }
    
    

    override func viewDidLoad() {
        
        ApiClient.sharedApiClient.fetchOrganization((self.chosenProyect?.id)!) { (org) in
            self.organization = org
            
            ApiClient.sharedApiClient.fetchProjectsOfOrg(org.id) { (projects) in
                self.organization?.projects = projects
            }

        }
        
               super.viewDidLoad()
        view.backgroundColor = .white
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
