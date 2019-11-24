//
//  DataService.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let instance = DataService()
    
    func createDBUser(firestoreRef: DocumentReference, userData: Dictionary<String, Any>) {
        firestoreRef.setData(userData)
    }
    
    func getProfile(completionHandler: @escaping (_ profile: Profile) -> Void) {
        let profileRef = Constants.FIRESTORE_DB_CURRENT_USER_PROFILE
        var profile: Profile?
        profileRef.getDocument(source: .default) { (document, error) in
               if let document = document, document.exists {
                profile = Profile.init(dictionary: document.data()!)
                completionHandler(profile!)
             } else {
                 print("Document does not exist")
             }
        }
    }
    
    func updateDBUser(firestoreRef: DocumentReference, userData: Dictionary<String, Any>) {
        firestoreRef.updateData(userData)
    }
}
