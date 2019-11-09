//
//  SecondViewController.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit

class DriveVC: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var driveTableView: UITableView!
    
    //MARK: VARIABLES
    var drives = [String]()
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        driveTableView.delegate = self
        driveTableView.dataSource = self
    }
    
    //MARK: ACTIONS
    @IBAction func addDrive(_ sender: Any) {
        drives.append("Drive 1")
        driveTableView.reloadData()
    }
    
}

//MARK: TABLEVIEW

extension DriveVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if drives.count == 0 {
            self.driveTableView.setEmptyMessage("You have not logged any drives yet, log a drive to see it here!")
        } else {
            self.driveTableView.restore()
        }

        return drives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = driveTableView.dequeueReusableCell(withIdentifier: "driveCell", for: indexPath)
        
        cell.textLabel?.text = drives[indexPath.row]
        
        return cell
    }
}
