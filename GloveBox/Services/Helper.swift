//
//  Helper.swift
//  GloveBox
//
//  Created by Nick George on 10/31/19.
//  Copyright © 2019 SimpleDev Studios. All rights reserved.
//

import UIKit
import Network

class Helper {
    static let instance = Helper()
    
        //MARK: Display Alert
        func displayAlert(alertTitle: String, message: String, actionTitle: String, style: UIAlertAction.Style, handler: @escaping ((UIAlertAction)->Void)) {
            let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: actionTitle, style: style, handler: handler)
            alertController.addAction(action)
            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        }
    }

class NetworkReachability {
    
    var pathMonitor: NWPathMonitor!
    var path: NWPath?
    lazy var pathUpdateHandler: ((NWPath) -> Void) = { path in
        self.path = path
        if path.status == NWPath.Status.satisfied {
            print("Connected")
        } else if path.status == NWPath.Status.unsatisfied {
            print("unsatisfied")
        } else if path.status == NWPath.Status.requiresConnection {
            print("requiresConnection")
        }
    }
    
    let backgroudQueue = DispatchQueue.global(qos: .background)
    
    init() {
        pathMonitor = NWPathMonitor()
        pathMonitor.pathUpdateHandler = self.pathUpdateHandler
        pathMonitor.start(queue: backgroudQueue)
    }
    
    func isNetworkAvailable() -> Bool {
        if let path = self.path {
            if path.status == NWPath.Status.satisfied {
                return true
            }
        }
        return false
    }
}

extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
