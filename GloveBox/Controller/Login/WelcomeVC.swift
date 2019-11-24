//
//  WelcomeVC.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Beta", message: "This app is currently under development. Accounts and data may possibly be erased and therefore be need to be created again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "welcomeToMain", sender: nil)
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
