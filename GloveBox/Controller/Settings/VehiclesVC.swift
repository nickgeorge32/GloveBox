//
//  VehiclesVC.swift
//  GloveBox
//
//  Created by Nick George on 11/9/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class VehiclesVC: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var vehicleTableView: UITableView!
    
    //MARK: VARIABLES
    var vehicles = [Vehicle]()
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        vehicleTableView.delegate = self
        vehicleTableView.dataSource = self
    }
    
    //MARK: ACTIONS
    @IBAction func back(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func addVehicle(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let newVehicleVC = storyboard.instantiateViewController(identifier: "AddVehicleVC")
        newVehicleVC.modalPresentationStyle = .fullScreen
        presentDetail(newVehicleVC)
    }
}

//MARK: TABLEVIEW
extension VehiclesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vehicles.count == 0 {
            self.vehicleTableView.setEmptyMessage("You do not have any vehicles yet, please add one first.")
        } else {
            self.vehicleTableView.restore()
        }
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vehicleTableView.dequeueReusableCell(withIdentifier: "vehicleCell", for: indexPath)
        
        cell.textLabel?.text = vehicles[indexPath.row].model
        
        return cell
    }
}
