//
//  Profile.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import Foundation
import Firebase

struct Profile {
    let name: String?
    let provider: String?
    let email: String?
    let verified: Bool?
    let dob: String?
    let devices: [String]?
    
    init() {
        self.name = ""
        self.provider = ""
        self.email = ""
        self.verified = false
        self.dob = ""
        self.devices = []
    }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
        let provider = dictionary["provider"] as? String, let email = dictionary["email"] as? String, let verified = dictionary["verified"] as? Bool, let dob = dictionary["dob"] as? String, let devices = dictionary["devices"] as? [String] else { return nil }
        self.name = name
        self.email = email
        self.provider = provider
        self.verified = verified
        self.dob = dob
        self.devices = devices

    }
    
    init(name: String, provider: String, email: String, verified: Bool, dob: String, devices: [String]) {
        self.name = name
        self.provider = provider
        self.email = email
        self.verified = verified
        self.dob = dob
        self.devices = devices
    }
    
    func createProfile(profile: Profile) -> [String:Any] {
        var myProfile: [String:Any] = [:]
        
        myProfile = [
            "name": name!,
            "provider": provider!,
            "email": email!,
            "verified": verified!,
            "dob": dob!,
            "devices": devices!
        ]
        
        return myProfile
    }
}
