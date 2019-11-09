//
//  MaintenanceVC.swift
//  GloveBox
//
//  Created by Nick George on 11/2/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit

class MaintenanceVC: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var maintenanceTableView: UITableView!
    
    //MARK: VARIABLES
    var maintenance = [String]()
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        maintenanceTableView.delegate = self
        maintenanceTableView.dataSource = self
    }
    
    //MARK: ACTIONS
    @IBAction func addMaintenance(_ sender: Any) {
        maintenance.append("New Maint")
        maintenanceTableView.reloadData()
    }
}

extension MaintenanceVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if maintenance.count == 0 {
            self.maintenanceTableView.setEmptyMessage("You have not logged any maintenance yet, log a maintenance event to see it here!")
        } else {
            self.maintenanceTableView.restore()
        }

        return maintenance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = maintenanceTableView.dequeueReusableCell(withIdentifier: "maintenanceCell", for: indexPath)
        cell.textLabel?.text = "Maintenance"
        
        return cell
    }
    
    
}
