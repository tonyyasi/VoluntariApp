//
//  Organization.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/28/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import Foundation

class Organization {
    
    var projects: [Project] = []
    var name: String!
    var description: String!
    var location: String!
    var id: Int!
    var created_at: String!
    var updated_at: String!
    
        func initialize(dictionary: NSDictionary){
            id = dictionary["id"] as! Int
            name = dictionary["name"] as! String
            description = dictionary["description"] as! String
            location = dictionary["location"] as! String
            created_at = dictionary["created_at"] as! String
            updated_at = dictionary["updated_at"] as! String
    }

    
    
    
}

/*
 projects[ ]
 name
 description
 location

 
 
 */