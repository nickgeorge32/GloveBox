//
//  GradientLine.swift
//  GloveBox
//
//  Created by Nick George on 11/11/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    //set your start color
    @IBInspectable var startColor:   UIColor = UIColor.black { didSet { updateColors() }}
    //set your end color
    @IBInspectable var endColor:     UIColor = UIColor.white { didSet { updateColors() }}
    //you can change anchors and directions
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
