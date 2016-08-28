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
            dispatch_async(dispatch_get_main_queue(), {
                 completionHandler(projectsArray)
            })
           
        }
        task.resume()
    }
    
    func fetchOrganization(let id: Int, completionHandler: OrganizationCompletionHandler){
        
        let path = Endpoints.OrganizationOfAProject(id).URL()
        let url = NSURL(string: path)
        let org = Organization()

        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            do {
                
                if(error != nil){
                    print(error)
                    
                    return
                }
               
        let array = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSArray

        let a = array[0]
                org.initialize(a as! NSDictionary)
        
    }
            catch{
                print("waddup dude")
            }
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(org)
            })
    
}
        task.resume()
}
    
    func fetchProjectsOfOrg(id: Int, completionHandler: [Project] -> Void){
        let path = Endpoints.ProjectsOfOrganization(id).URL()
        let url = NSURL(string: path)
        var projectArray: [Project] = []
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            do {
                var array = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSArray
                var cont = 1
                
                for i in 1...array.count-1{
                    let proy = Project()
                    proy.initialize(array[i] as! NSDictionary)
                projectArray.append(proy)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                   completionHandler(projectArray)
                })
                
            }
            catch{
                print("No ahora porfavor")
            }
        }
        task.resume()
    }
}
