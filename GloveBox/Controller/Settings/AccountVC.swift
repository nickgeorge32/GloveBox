//
//  AccountVC.swift
//  GloveBox
//
//  Created by Nick George on 11/9/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
    //MARK: OUTLETS
    
    //MARK: VARIABLES
    var userProfile = Profile.init()
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        userProfile.getProfile()
    }
    
    //MARK: ACTIONS
    @IBAction func back(_ sender: Any) {
        dismissDetail()
    }
    
}
