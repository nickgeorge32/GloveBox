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
        
                Auth.auth().addStateDidChangeListener { (auth, user) in
                    if Auth.auth().currentUser != nil {
                        self.performSegue(withIdentifier: "welcomeToMain", sender: nil)
                    }
                }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let alert = UIAlertController(title: "Beta", message: "This app is currently under development. Accounts and data may possibly be erased and therefore be need to be created again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
