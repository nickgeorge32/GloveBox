//
//  LoginButton.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit

@IBDesignable
class LoginButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        signupbutton()
    }
    
    override func prepareForInterfaceBuilder() {
        signupbutton()
    }
    
    func signupbutton() {
        backgroundColor = Constants.Colors.light2
        layer.cornerRadius = 8.0
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }

}
