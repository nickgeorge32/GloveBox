//
//  LoginVC.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var emailField: LoginTextField!
    @IBOutlet weak var passwordField: LoginTextField!
    @IBOutlet weak var emailSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: VARIABLES
    let defaults = UserDefaults.standard
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        if defaults.string(forKey: "email") != nil {
            emailField.text = defaults.string(forKey: "email")
            emailSwitch.setOn(defaults.bool(forKey: "emailSwitch"), animated: true)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //MARK: ACTIONS
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let forgotPasswordVC = storyboard.instantiateViewController(identifier: "ForgotPassword")
        forgotPasswordVC.modalPresentationStyle = .fullScreen
        presentDetail(forgotPasswordVC)
        
    }
    
    @IBAction func login(_ sender: Any) {
        if emailSwitch.isOn {
            defaults.set(true, forKey: "emailSwitch")
            defaults.set(emailField.text, forKey: "email")
        } else {
            defaults.set(false, forKey: "emailSwitch")
            defaults.set(nil, forKey: "email")
        }
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
            if error == nil {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                //FIRESTORE_DB_CURRENT_USER.updateData(["Devices" : UIDevice.current.name])
                
                self.performSegue(withIdentifier: "loginToMain", sender: nil)
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
