//
//  ViewController.swift
//  MovieList
//
//  Created by Cristian Petra on 06.10.2021.
//

import UIKit
import Model

class ViewController: UIViewController {

    let services: MovieServiceProvider = MovieServiceProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        services.searchMovie(with: "forest")
    }

}

