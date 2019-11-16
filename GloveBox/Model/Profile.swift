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
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        
        self.provider = dictionary["provider"] as? String
        self.email = dictionary["email"] as? String
        self.verified = dictionary["verified"] as? Bool
        self.dob = dictionary["dob"] as? String
        self.devices = dictionary["devices"] as? [String]

    }
    
    init() {
        self.name = ""
        self.provider = ""
        self.email = ""
        self.verified = false
        self.dob = ""
        self.devices = []
    }
    
    init(name: String, provider: String, email: String, verified: Bool, dob: String, sector: String, subscription: String, purchaseDate: String, expirationDate: String, devices: [String]) {
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
    
    func getProfile() {
        let profileRef = Constants.FIRESTORE_DB_CURRENT_USER
        profileRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let doc = document.data()
                print(doc)
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
