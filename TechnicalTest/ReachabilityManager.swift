//
//  ReachabilityManager.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 3/12/21.
//

import Foundation
import Reachability

class ReachabilityManager: NSObject {
    
    private override init() {
        super.init()
        
        reachability = try! Reachability()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleNetworkStatusChanges(_:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    var reachability: Reachability!
    
    static let shared = ReachabilityManager()
    
    @objc private func handleNetworkStatusChanges(_ notification: Notification) {
//        if let reachability = notification.object as? Reachability {
//            if reachability.connection == .unavailable {
//                print("Presentar OfflineViewController")
//                let controller = OfflineViewController()
//                controller.modalPresentationStyle = .fullScreen
//                UIViewController.topMostViewController().present(controller, animated: true)
//            } else {
//                if let controller = UIViewController.topMostViewController() as? OfflineViewController {
//                    controller.dismiss(animated: true)
//                }
//            }
//        }
    }
    
    static func isReachable(completed: @escaping (ReachabilityManager) -> Void) {
        if ReachabilityManager.shared.reachability.connection != .unavailable {
            completed(ReachabilityManager.shared)
        }
    }
    
    static func isUnreachable(completed: @escaping (ReachabilityManager) -> Void) {
        if ReachabilityManager.shared.reachability.connection == .unavailable {
            completed(ReachabilityManager.shared)
        }
    }
    
    static func isReachableViaWWAN(completed: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.shared.reachability).connection == .cellular {
            completed(ReachabilityManager.shared)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (ReachabilityManager) -> Void) {
        if (ReachabilityManager.shared.reachability).connection == .wifi {
            completed(ReachabilityManager.shared)
        }
    }
    
}
