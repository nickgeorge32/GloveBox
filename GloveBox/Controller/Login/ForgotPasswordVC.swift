//
//  ForgotPasswordVC.swift
//  GloveBox
//
//  Created by Nick George on 12/7/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: ACTIONS
    @IBAction func back(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendResetEmail(_ sender: Any) {
        if emailTextField.text != "" {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
                if error == nil {
                    self.dismissDetail()
                }
            }
        } else {
            let alert = UIAlertController(title: "Missing Email", message: "Please enter an email to have the instuctions sent to you.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            }))
            present(alert, animated: true, completion: nil)
        }

    }
}
