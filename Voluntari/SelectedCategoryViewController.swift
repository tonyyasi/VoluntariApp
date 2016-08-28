//
//  SelectedCategoryViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/28/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class SelectedCategoryViewController: UIViewController {
    
    var selectedCategory: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = selectedCategory
        view.backgroundColor = ColorPalette.background
        navigationItem.title = selectedCategory

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
