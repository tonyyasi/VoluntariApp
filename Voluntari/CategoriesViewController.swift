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
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        self.navigationItem.title = "Categories"
                
        ApiClient.sharedApiClient.fetchProjects { (projectArray) in
            self.array = projectArray
            print("a")
        }
        
        let logOutButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CategoriesViewController.logOut))
        
        navigationItem.rightBarButtonItem = logOutButton

        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func logOut(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let vc = storyboard?.instantiateViewController(withIdentifier: "first")
        present(vc!, animated: false, completion: nil)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SelectedCategoryViewController
            vc.selectedCategory = self.selectedCategory
        var chosenProjects: [Project] = []
        var temp = self.selectedCategory
        temp = temp?.capitalized
        for projects in array {
            if(projects.category == self.selectedCategory || projects.category == temp){
                chosenProjects.append(projects)
            }
        }
        vc.chosen = chosenProjects
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print((indexPath as NSIndexPath).row)
        if let cat = categorias[(indexPath as NSIndexPath).row] as? String{
            self.selectedCategory = cat
        }
        
        performSegue(withIdentifier: "category", sender: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! collectionViewCell
        cell.contentView.backgroundColor = .white
        cell.cellImage.image = imageArray[(indexPath as NSIndexPath).row]
        cell.categoryTitle.text = categorias[(indexPath as NSIndexPath).row]
        
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
