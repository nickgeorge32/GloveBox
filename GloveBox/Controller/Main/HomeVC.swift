//
//  FirstViewController.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: OUTLETS
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    //MARK: VARIABLES
    var cells = ["Vehicle Health","Recalls","Documents"]
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
    }
    
    //MARK: COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! MainCVC
        
        cell.cellLabel.text = cells[indexPath.row]
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 300)
    }
}
