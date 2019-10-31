//
//  SignUpVC.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var fullNameField: LoginTextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: VARIABLES
    let defaults = UserDefaults.standard
    
    //MARK: LIFECYCLRE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
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
    
    @IBAction func signUp(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            
            if error == nil {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
                let myProfile = Profile.init(name: self.fullNameField.text!, provider: Auth.auth().currentUser?.providerID ?? "", email: self.emailField.text!, verified: false, dob: "", sector: "", subscription: "", purchaseDate: "", expirationDate: "", devices: [String(UIDevice.current.name)])
                
                let myProfileDict = myProfile.createProfile(profile: myProfile)
                
                self.defaults.set(myProfileDict, forKey: "profile")
                
                DataService.instance.createDBUser(firestoreRef: Constants.FIRESTORE_DB.document("users/\((Auth.auth().currentUser?.uid)!)/Personal/Profile"), userData: myProfileDict)
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.fullNameField.text
                changeRequest?.commitChanges(completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        //TODO: Uncomment
                        //                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        //                        if let error = error {
                        //                            print(error.localizedDescription)
                        //                        }
                        //                    })
                        
                        self.performSegue(withIdentifier: "signUpToMain", sender: nil)
                    }
                })
                
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                Helper.instance.displayAlert(alertTitle: "Error", message: (error?.localizedDescription)!, actionTitle: "OK", style: .default, handler: { _ in
                    
                })
            }
        }
    }
}
