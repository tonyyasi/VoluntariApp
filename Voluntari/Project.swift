//
//  Project.swift
//  Voluntari
//
//  Created by Tony Toussaint on 8/27/16.
//  Copyright © 2016 Tony Toussaint. All rights reserved.
//

import Foundation

class Project {
    
    var name: String!
    var capacity: Int!
    var description: String!
    var category: String!
    var date: String!
    var freeSpaces: Int!
    var moneyDonated: Int!
    var place: String!
    var id: Int!
    
    func initialize(dictionary: NSDictionary){
        name = dictionary["name"] as! String
        capacity = dictionary["capacity"] as! Int
        description = dictionary["description"] as! String
        category = dictionary["categories"] as! String
        date = dictionary["date"] as! String
        freeSpaces = dictionary["free_spaces"] as! Int
        moneyDonated = dictionary["money_donated"] as! Int
        place = dictionary["place"] as! String
        id = dictionary["id"] as! Int
    }
    
    
}

/*
 name
 capacity
 description
 categories
 date
 free_spaces
 money_donated
 place

 
 */