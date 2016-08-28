//
//  CategoriesViewController.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let categorias = ["reforestacion", "Campamentos", "Programación" , "Educación", "Medicina", "Alimentación"]
    var selectedCategory: String?
    
    var array: [Project] = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let imageArray = [UIImage(named: "arboles"), UIImage(named: "3"), UIImage(named: "programa"), UIImage(named:"school"), UIImage(named: "medi") , UIImage(named: "comida")]
    
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = ColorPalette.background
        collectionView.backgroundColor = ColorPalette.background
        self.navigationItem.title = "Categories"
        
        ApiClient.sharedApiClient.fetchProjects { (projectArray) in
            self.array = projectArray
            print("a")
        }
        
        let logOutButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CategoriesViewController.logOut))
        
        navigationItem.rightBarButtonItem = logOutButton

        // Do any additional setup after loading the view.
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func logOut(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let vc = storyboard?.instantiateViewControllerWithIdentifier("first")
        presentViewController(vc!, animated: false, completion: nil)
        
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! SelectedCategoryViewController
            vc.selectedCategory = self.selectedCategory
        var chosenProjects: [Project] = []
        var temp = self.selectedCategory
        temp = temp?.capitalizedString
        for projects in array {
            if(projects.category == self.selectedCategory || projects.category == temp){
                chosenProjects.append(projects)
            }
        }
        vc.chosen = chosenProjects
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        if let cat = categorias[indexPath.row] as? String{
            self.selectedCategory = cat
        }
        
        performSegueWithIdentifier("category", sender: nil)
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ccell", forIndexPath: indexPath) as! collectionViewCell
        cell.contentView.backgroundColor = ColorPalette.background
        cell.cellImage.image = imageArray[indexPath.row]
        cell.categoryTitle.text = categorias[indexPath.row]
        
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
