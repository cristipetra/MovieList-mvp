//
//  UIViewController+Extension.swift
//  MovieList
//
//  Created by Cristian Petra on 13.10.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func placeholderView(with status: PlaceholderStatus, color: UIColor = .clear, rect: CGRect = CGRect.zero) -> PlaceholderView {
        let placeholder = PlaceholderView(frame: rect.width == 0 ? view.bounds : rect)
        placeholder.title.text = status.title
        placeholder.backgroundColor = color
        return placeholder
    }
}

extension UIViewController {
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: { action in
            
                                })
        let _ = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(ok)
        //alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
}
