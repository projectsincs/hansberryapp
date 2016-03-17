//
//  Vegetable.swift
//  sunflower
//
//  Created by Leonard Jones on 3/16/16.
//  Copyright © 2016 Leonard Jones. All rights reserved.
//

import UIKit

class Vegetable {
    
    var id: String?
    var name: String?
    var photo_url: String?
    var plantingDate: [NSDate]?
    var midSeasonDate: [NSDate]?
    var harvestDate: [NSDate]?
    
    init(json: NSDictionary){
        self.id = json["id"] as? String
        self.name = json["name"] as? String
        self.photo_url = json["photo_url"] as? String
        self.plantingDate = json["planting_date"] as? [NSDate]
        self.midSeasonDate = json["mid_season_date"] as? [NSDate]
        self.harvestDate = json["harvest_date"] as? [NSDate]
    }
}
