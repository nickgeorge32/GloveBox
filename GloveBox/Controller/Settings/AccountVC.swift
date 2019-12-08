//
//  AccountVC.swift
//  GloveBox
//
//  Created by Nick George on 11/9/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class AccountVC: FormViewController {
    //MARK: OUTLETS
    
    //MARK: VARIABLES
    var userProfile = Profile.init()
    var devices = [String]()
    let user = Auth.auth().currentUser
    
    //MARK: LIFECYCLE    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        DataService.instance.getProfile { (profile) in
            self.userProfile = profile
            self.devices = profile.devices!
            
            self.setupForm()
        }
    }
    
    //MARK: ACTIONS
    @IBAction func back(_ sender: Any) {
        dismissDetail()
    }
    
    //MARK: FORM
    func setupForm() {
        
        form +++ Section()
            
            <<< TextRow("name"){
                $0.title = "Name"
                $0.value = userProfile.name
            }
            
            <<< DateRow("dob") {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let isoDate = "2019-01-01"
                var date = Date()
                if userProfile.dob != "" {
                    date = dateFormatter.date(from: userProfile.dob!)!
                    $0.value = date
                } else {
                    date = dateFormatter.date(from: isoDate)!
                    $0.value = date
                }
                $0.title = "DoB"
                $0.cell.detailTextLabel?.textColor = UIColor.black
            }
            
            <<< EmailRow("email") {
                $0.title = "Email"
                $0.value = userProfile.email
                $0.add(rule: RuleEmail())
                $0.baseCell.isUserInteractionEnabled = false
            }
            
            <<< LabelRow("verified") {
                $0.title = "Verified"
                $0.cell.detailTextLabel?.textColor = UIColor.black
                if Auth.auth().currentUser!.isEmailVerified {
                    $0.value = "Verified"
                } else {
                    $0.value = "Verify"
                    $0.cell.detailTextLabel?.textColor = UIColor.systemBlue
                }
            }.onCellSelection({ (cell, row) in
                if Auth.auth().currentUser!.isEmailVerified {
                    
                } else {
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if let error = error {
                            print(error)
                            let alert = UIAlertController(title: "Error", message: "Unable to send verification email, please try again later.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                }
            })
            
            +++ Section("Devices")
            <<< TextRow() {
                $0.title = UIDevice.current.name + "(This Device)"
            }
            
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Save Changes"
            }.onCellSelection({ (cell, row) in
                //1. Create the alert controller.
                let alert = UIAlertController(title: "Re-Authenticate", message: "Enter your old email and password", preferredStyle: .alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                    textField.placeholder = "Email"
                }
                alert.addTextField { (textfield) in
                    textfield.placeholder = "Password"
                    textfield.isSecureTextEntry = true
                }
                
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    
                }))
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let credential = EmailAuthProvider.credential(withEmail: (alert?.textFields![0].text!)!, password: (alert?.textFields![1].text!)!)
                    Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
                        if let error = error {
                            let alert = UIAlertController(title: "Error", message: "Unable to authenticate user credentials, please try again.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            for row in self.form.rows {
                                row.baseCell.isUserInteractionEnabled = true
                            }
                        }
                    })
                }))
                
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
            })
            
            +++ Section()
            
            <<< ButtonRow() {
                $0.title = "Update Email"
            }.onCellSelection({ (cell, row) in
                let emailAlert = UIAlertController(title: "Update Email", message: "Please enter your new email.", preferredStyle: .alert)
                emailAlert.addTextField { (textfield) in
                    textfield.placeholder = "New Email"
                }
                emailAlert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action) in
                    if emailAlert.textFields![0].text != "" {
                        let authAlert = UIAlertController(title: "Re-Authenticate", message: "Enter your old email and password", preferredStyle: .alert)
                        
                        //2. Add the text field. You can configure it however you need.
                        authAlert.addTextField { (textField) in
                            textField.placeholder = "Email"
                        }
                        authAlert.addTextField { (textfield) in
                            textfield.placeholder = "Password"
                            textfield.isSecureTextEntry = true
                        }
                        
                        // 3. Grab the value from the text field, and print it when the user clicks OK.
                        authAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                            
                        }))
                        authAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak authAlert] (_) in
                            let credential = EmailAuthProvider.credential(withEmail: (authAlert?.textFields![0].text!)!, password: (authAlert?.textFields![1].text!)!)
                            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
                                if let error = error {
                                    let alert = UIAlertController(title: "Error", message: "Unable to authenticate user credentials, please try again.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                        
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    Auth.auth().currentUser?.updateEmail(to: emailAlert.textFields![0].text!, completion: { (error) in
                                        
                                    })
                                }
                            })
                        }))
                        
                        // 4. Present the alert.
                        self.present(authAlert, animated: true, completion: nil)
                        
                        Auth.auth().currentUser?.updateEmail(to: "nick@gmail.com", completion: { (error) in
                            
                        })
                    } else {
                        
                    }
                }))
                self.present(emailAlert, animated: true, completion: nil)
            })
            
            <<< ButtonRow() {
                $0.title = "Change Password"
            }.onCellSelection({ (cell, row) in
                let passwordAlert = UIAlertController(title: "Change Password", message: "Please enter your new password", preferredStyle: .alert)
                passwordAlert.addTextField { (textfield) in
                    textfield.placeholder = "New Password"
                    textfield.isSecureTextEntry = true
                }
                passwordAlert.addAction(UIAlertAction(title: "Change", style: .default, handler: { (action) in
                    if passwordAlert.textFields![0].text != nil {
                        let authAlert = UIAlertController(title: "Re-Authenticate", message: "Enter your old email and password", preferredStyle: .alert)
                        
                        //2. Add the text field. You can configure it however you need.
                        authAlert.addTextField { (textField) in
                            textField.placeholder = "Email"
                        }
                        authAlert.addTextField { (textfield) in
                            textfield.placeholder = "Password"
                            textfield.isSecureTextEntry = true
                        }
                        
                        // 3. Grab the value from the text field, and print it when the user clicks OK.
                        authAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                            
                        }))
                        authAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak authAlert] (_) in
                            let credential = EmailAuthProvider.credential(withEmail: (authAlert?.textFields![0].text!)!, password: (authAlert?.textFields![1].text!)!)
                            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
                                if let error = error {
                                    let alert = UIAlertController(title: "Error", message: "Unable to authenticate user credentials, please try again.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                        
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    Auth.auth().currentUser?.updatePassword(to: passwordAlert.textFields![0].text!, completion: { (error) in
                                        
                                    })
                                }
                            })
                        }))
                        
                        // 4. Present the alert.
                        self.present(authAlert, animated: true, completion: nil)
                    } else {
                        
                    }
                }))
                self.present(passwordAlert, animated: true, completion: nil)
            })
            
            <<< ButtonRow() {
                $0.title = "Delete Account"
            }.onCellSelection({ (cell, row) in
                //Delete the user document
                Constants.FIRESTORE_DB_CURRENT_USER_PROFILE.delete() { error in
                    if let error = error {
                        //error deleting document
                        print("Error removing document: \(error)")
                    } else {
                        //document deleted, delete user
                        self.user?.delete(completion: { (error) in
                            if let error = error {
                                // An error happened deleting the user
                                let alert = UIAlertController(title: "Error", message: "Unable to delete account, please try again later.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                    
                                }))
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                //no errors, document and user deleted, segue to WelcomeVC
                                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                                let welcomeVC = storyboard.instantiateViewController(identifier: "WelcomeVC")
                                welcomeVC.modalPresentationStyle = .fullScreen
                                self.present(welcomeVC, animated: true, completion: nil)
                            }
                        })
                    }
                }
            }).cellUpdate({ (cell, row) in
                cell.textLabel?.textColor = UIColor.red
            })
    }
}

//MARK: EXTENSIONS
extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
