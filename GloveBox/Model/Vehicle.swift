//
//  Vehicle.swift
//  GloveBox
//
//  Created by Nick George on 11/24/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import Foundation
import Firebase

struct Vehicle {
    let year: String?
    let make: String?
    let model: String?
    let trim: String?
    let color: String?
    let vin: String?
    
    
    init() {
        self.year = ""
        self.make = ""
        self.model = ""
        self.trim = ""
        self.color = ""
        self.vin = ""
    }
    
//    init?(dictionary: [String: Any]) {
//        guard let name = dictionary["name"] as? String,
//            let provider = dictionary["provider"] as? String, let email = dictionary["email"] as? String, let verified = dictionary["verified"] as? Bool, let dob = dictionary["dob"] as? String, let devices = dictionary["devices"] as? [String] else { return nil }
//        self.name = name
//        self.email = email
//        self.provider = provider
//        self.verified = verified
//        self.dob = dob
//        self.devices = devices
//    }
    
    init(year: String, make: String, model: String, trim: String, color: String, vin: String) {
        self.year = year
        self.make = make
        self.model = model
        self.trim = trim
        self.color = color
        self.vin = vin
    }
}
