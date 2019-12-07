//
//  AddVehicle.swift
//  GloveBox
//
//  Created by Nick George on 11/25/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Eureka
import Firebase
import Alamofire
import SwiftyJSON

class AddVehicleVC: FormViewController {
    //MARK: OUTLETS
    
    //MARK: VARIABLES
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        self.setupForm()
        
        Alamofire.request("https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvaluesextended/JF1SF63591H741743?format=json").responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let res = json["Results"]
                print("Make is \(res.arrayValue.map {$0["Make"].stringValue})")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: ACTIONS
    @IBAction func backBtn(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func saveVehicle(_ sender: Any) {
        
    }
    
    func setupForm() {
        form +++ Section()
            
            <<< PickerInputRow<String>("year"){
                $0.title = "Year"
                $0.options = Constants.YEAR
            }
            
            <<< PickerInputRow<String>("make"){
                $0.title = "Make"
                $0.options = Constants.MAKE
            }
            
            <<< PickerInputRow<String>("model") {
                $0.title = "Model"
                $0.options = Constants.MODEL
            }
            
            <<< PickerInputRow<String>("trim") {
                $0.title = "Trim"
                $0.options = Constants.TRIM
        }
        
            <<< PickerInputRow<String>("color") {
                $0.title = "Color"
                $0.options = Constants.COLOR
        }
        
        for row in form.rows {
            row.baseCell.isUserInteractionEnabled = true
        }
    }
}
