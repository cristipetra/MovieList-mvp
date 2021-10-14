//
//  PlaceholderView.swift
//  MovieList
//
//  Created by Cristian Petra on 13.10.2021.
//

import Foundation
import UIKit


class PlaceholderView: UIView {
    
    public private(set) var title: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        backgroundColor = .blue
        
        title = UILabel()
        self.addSubview(title)
        
        addConstraints()
    }
    
    private func addConstraints() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    }
}
