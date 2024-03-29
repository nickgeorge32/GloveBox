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
    @IBOutlet weak var editSaveBtn: UIButton!
    
    //MARK: VARIABLES
    var userProfile = Profile.init()
    var editSaveToggle = false
    var devices = [String]()
    
    //MARK: LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        DataService.instance.getProfile { (profile) in
            self.userProfile = profile
            self.devices = profile.devices!
            
            print(self.userProfile)
            
            self.setupForm()
        }
    }
    
    //MARK: ACTIONS
    @IBAction func back(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func editSave(_ sender: Any) {
        if editSaveToggle == false {
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
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                let textField2 = alert?.textFields![1]
                
                let credential = EmailAuthProvider.credential(withEmail: (alert?.textFields![0].text!)!, password: (alert?.textFields![1].text!)!)
                Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
                    if let error = error {
                        let alert = UIAlertController(title: "Error", message: "Unable to authenticate user credentials, please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        print("reauthenticated")
                        self.editSaveBtn.setTitle("Save", for: .normal)
                        self.editSaveToggle = true
                        
                        for row in self.form.rows {
                            row.baseCell.isUserInteractionEnabled = true
                        }
                    }
                })
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
        } else {
            editSaveBtn.setTitle("Edit", for: .normal)
            editSaveToggle = false
            
            for row in form.rows {
                row.baseCell.isUserInteractionEnabled = false
                row.baseCell.cellResignFirstResponder()
            }
            
            let nameRow: TextRow = form.rowBy(tag: "name")!
            let nameValue = nameRow.value!
            let emailRow: TextRow = form.rowBy(tag: "email")!
            let emailValue = emailRow.value!
            let dobRow: DateRow = form.rowBy(tag: "dob")!
            let dobValue = (dobRow.value)!
            
            if !devices.contains(String(UIDevice.current.name)) {
                devices.append(String(UIDevice.current.name))
            }
            
            let myProfile = Profile.init(name: nameValue, provider: Auth.auth().currentUser!.providerID, email: emailValue, verified: userProfile.verified!, dob: String(describing: dobValue.toString(dateFormat: "yyyy-MM-dd")), devices: devices)
            
            let myProfileDict = myProfile.createProfile(profile: myProfile)
            
            DataService.instance.updateDBUser(firestoreRef: Constants.FIRESTORE_DB.document("users/\((Auth.auth().currentUser?.uid)!)/Personal/Profile"), userData: myProfileDict)
            
            let user = Auth.auth().currentUser
            user?.updateEmail(to: emailValue, completion: { (error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Unable to update email, please try again later.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
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
            }
            
            <<< TextRow("email") {
                $0.title = "Email"
                $0.value = userProfile.email
        }
        
            <<< TextRow("verified") {
                $0.title = "Verified"
                $0.value = "Not Verified"
                $0.disabled = true
        }
        
        +++ Section("Devices")
            <<< TextRow() {
                $0.title = UIDevice.current.name + "(This Device)"
        }
        
        for row in form.rows {
            row.baseCell.isUserInteractionEnabled = false
        }
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
