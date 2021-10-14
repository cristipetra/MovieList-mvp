//
//  UIImageView+Extension.swift
//  MovieList
//
//  Created by Cristian Petra on 12.10.2021.
//

import UIKit

extension UIImageView {
    func set(imageUrl: URL?, placeholder: UIImage? = nil) {
        if let url = imageUrl {
            self.kf.setImage(with: url, placeholder: placeholder)
        } else {
            self.image = placeholder
        }
    }
}
