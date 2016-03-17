//
//  Member.swift
//  sunflower
//
//  Created by Leonard Jones on 12/6/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class User {
    
    var id: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var city: String?
    var state: String?
    var dateCreated: String?
    
    init(json: NSDictionary){
        self.id = json["user_id"] as? String
        self.email = json["email"] as? String
        self.firstName = json["first_name"] as? String
        self.lastName = json["last_name"] as? String
        self.city = json["city"] as? String
        self.state = json["state"] as? String
        self.dateCreated = json["date_created"] as? String
    }
}
