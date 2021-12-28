//
//  Extension+UIViewController.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 3/12/21.
//

import UIKit

extension UIViewController {
    /// Get the top most view in the app
    /// — Returns: It returns current foreground UIViewcontroller
    static func topMostViewController() -> UIViewController {
        var topViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }
}
