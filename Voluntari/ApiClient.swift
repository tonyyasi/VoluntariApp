//
//  ApiClient.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/28/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import Foundation

enum Endpoints {
    case organization()
    case projectsOfOrganization(Int)
    case projects()
    case especificProject(Int)
    case organizationOfAProject(Int)
    
    func URL()->String{
        let path:String!
        
        switch self {
        case .organization(let id):
            path = "organizations/\(id)"
        case .projectsOfOrganization(let number):
            path = "organizations/\(number)"
        case .projects():
            path = "projects"
        case .especificProject(let id):
            path = "projects/\(id)"
        case .organizationOfAProject(let id):
            path = "projects/\(id)"
        }
        return ApiClient.baseURL + path
    }
}

typealias ProjectsCompletionHandler = ([Project]) -> Void
typealias OrganizationCompletionHandler = (Organization) -> Void

class ApiClient{
    
    static let sharedApiClient = ApiClient()
    static let baseURL = "https://nameless-forest-54224.herokuapp.com/api/v1/"
    
    func fetchProjects(_ completionHandler: @escaping ProjectsCompletionHandler){
        let path = Endpoints.projects().URL()
        let url = URL(string: path)
        
        var projectsArray: [Project] = []
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            do {
            
            if(error != nil){
                print(error)
                
                return
            }
            
            
            
            let array = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                
                for projs in array  {
                    let proy = Project()
                    proy.initialize(projs as! NSDictionary)
                    projectsArray.append(proy)
                }
            
        }
            catch{
                print("error")
            }
            DispatchQueue.main.async(execute: {
                 completionHandler(projectsArray)
            })
           
        }) 
        task.resume()
    }
    
    func fetchOrganization(_ id: Int, completionHandler: @escaping OrganizationCompletionHandler){
        
        let path = Endpoints.organizationOfAProject(id).URL()
        let url = URL(string: path)
        let org = Organization()

        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            do {
                
                if(error != nil){
                    print(error)
                    
                    return
                }
               
        let array = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray

        let a = array[0]
                org.initialize(a as! NSDictionary)
        
    }
            catch{
                print("waddup dude")
            }
            DispatchQueue.main.async(execute: {
                completionHandler(org)
            })
    
}) 
        task.resume()
}
    
    func fetchProjectsOfOrg(_ id: Int, completionHandler: @escaping ([Project]) -> Void){
        let path = Endpoints.projectsOfOrganization(id).URL()
        let url = URL(string: path)
        var projectArray: [Project] = []
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            do {
                var array = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                var cont = 1
                
                for i in 1...array.count-1{
                    let proy = Project()
                    proy.initialize(array[i] as! NSDictionary)
                projectArray.append(proy)
                }
                
                DispatchQueue.main.async(execute: {
                   completionHandler(projectArray)
                })
                
            }
            catch{
                print("No ahora porfavor")
            }
        }) 
        task.resume()
    }
}
