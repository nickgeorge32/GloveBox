//
//  TableViewExtensions.swift
//  GloveBox
//
//  Created by Nick George on 11/9/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "AvenirNext", size: 16)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
