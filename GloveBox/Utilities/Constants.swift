//
//  Constants.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    static let FIRESTORE_DB = Firestore.firestore()
    static let FIRESTORE_DB_USERS = Firestore.firestore().collection("users")
    static let FIRESTORE_DB_CURRENT_USER_DOCUMENT = Firestore.firestore().collection("users").document((Auth.auth().currentUser?.uid)!)
    static let FIRESTORE_DB_CURRENT_USER_PROFILE = Firestore.firestore().collection("users").document((Auth.auth().currentUser?.uid)!).collection("Personal").document("Profile")

    
    struct Colors {
        static let headerColor = #colorLiteral(red: 0.007843137255, green: 0.1607843137, blue: 0.462745098, alpha: 1)
        static let mainColor = #colorLiteral(red: 0.1137254902, green: 0.2941176471, blue: 0.6549019608, alpha: 1)
        static let secondaryColor = #colorLiteral(red: 0.05490196078, green: 0.2196078431, blue: 0.5411764706, alpha: 1)
        static let light2 = #colorLiteral(red: 0.262745098, green: 0.431372549, blue: 0.7607843137, alpha: 1)
        static let light1 = #colorLiteral(red: 0.3764705882, green: 0.5294117647, blue: 0.8352941176, alpha: 1)
    }
}
