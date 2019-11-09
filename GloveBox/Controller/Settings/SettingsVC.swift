//
//  SettingsVC.swift
//  GloveBox
//
//  Created by Nick George on 11/2/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: VARIABLES
    var options = ["Logout"]
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK:TABLEVIEW
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = UIColor.clear
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return options.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
            
            cell.textLabel?.text = options[indexPath.row]
            cell.textLabel?.textColor = Constants.Colors.headerColor
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
            
            if cell?.textLabel?.text == "Logout" {
                    let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
                let logout = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
                    do {
                        try Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "profile")
                        self.performSegue(withIdentifier: "logout", sender: nil)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(logout)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }
        }
    }
