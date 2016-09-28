//
//  FacebookUser.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import Foundation

class User {
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var picture: String!
    
    func initialize(_ dictionary: AnyObject){
        firstName = dictionary["first_name"] as! String
        lastName = dictionary["last_name"] as! String
        email = dictionary["email"] as! String
        picture = "a"
    }
    
}
