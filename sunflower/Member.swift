//
//  Member.swift
//  sunflower
//
//  Created by Leonard Jones on 12/6/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class Member {
    
    var member_id: String?
    var firstName: String?
    var lastName: String?
    var address: String?
    var phoneNumber: String?
    var email: String?
    var joinDate: String?
    var bedNumber: String?
    
    init(json: NSDictionary){
        self.member_id = json["user_id"] as? String
        self.firstName = json["first_name"] as? String
        self.lastName = json["last_name"] as? String
        self.address = json["address"] as? String
        self.phoneNumber = json["phone_number"] as? String
        self.joinDate = json["join_date"] as? String
        self.bedNumber = json["bed_number"] as? String
    }
}
