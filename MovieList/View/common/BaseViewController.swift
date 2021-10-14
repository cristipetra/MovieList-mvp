//
//  BaseViewController.swift
//  MovieList
//
//  Created by Cristian Petra on 13.10.2021.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
            do {
              try reachability.startNotifier()
            } catch {
              print("could not start reachability notifier")
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")
          showAlert(withTitle: "No internet connection.", withMessage: "")
      case .none:
          print("none")
      }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)

    }
}
