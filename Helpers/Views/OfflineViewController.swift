//
//  OfflineViewController.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 3/12/21.
//

import UIKit

class OfflineViewController: UIViewController {

    //MARK: Properties
    private let reachabilityManager = ReachabilityManager.shared
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        reachabilityManager.reachability.whenReachable = { [weak self] reachability in
//            self?.dismiss(animated: true)
//        }
    }

}
