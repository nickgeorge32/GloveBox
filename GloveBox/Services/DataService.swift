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
}
