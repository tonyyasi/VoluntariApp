//
//  ApiClient.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/28/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import Foundation

enum Endpoints {
    case Organization()
    case ProjectsOfOrganization(Int)
    case Projects()
    case EspecificProject(Int)
    case OrganizationOfAProject(Int)
    
    func URL()->String{
        let path:String!
        
        switch self {
        case .Organization(let id):
            path = "organizations/\(id)"
        case .ProjectsOfOrganization(let number):
            path = "organizations/\(number)"
        case .Projects():
            path = "projects"
        case .EspecificProject(let id):
            path = "projects/\(id)"
        case .OrganizationOfAProject(let id):
            path = "projects/\(id)"
        }
        return ApiClient.baseURL + path
    }
}

typealias ProjectsCompletionHandler = [Project] -> Void
typealias OrganizationCompletionHandler = Organization -> Void

class ApiClient{
    
    static let sharedApiClient = ApiClient()
    static let baseURL = "https://nameless-forest-54224.herokuapp.com/api/v1/"
    
    func fetchProjects(completionHandler: ProjectsCompletionHandler){
        let path = Endpoints.Projects().URL()
        let url = NSURL(string: path)
        
        var projectsArray: [Project] = []
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            do {
            
            if(error != nil){
                print(error)
                
                return
            }
            
            
            
            let array = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSArray
                
                for projs in array  {
                    let proy = Project()
                    proy.initialize(projs as! NSDictionary)
                    projectsArray.append(proy)
                }
            
        }
            catch{
                print("error")
            }
            completionHandler(projectsArray)
        }
        task.resume()
    }
    
    func fetchOrganization(let id: Int, completionHandler: OrganizationCompletionHandler){
        
        let path = Endpoints.OrganizationOfAProject(id).URL()
        let url = NSURL(string: path)
        
        let org = Organization()
        
        org.in
        
    }
    
}
