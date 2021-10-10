//
//  FavoritesMovieViewController.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import UIKit

class FavoritesMovieViewController: UIViewController {

    var viewModel: FavoritesViewModel!
    
    // actions
    var onSearch: DoneHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .blue
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(handlerSearch))
    }
    
}

// MARK: - actions
extension FavoritesMovieViewController {
    @objc func handlerSearch() {
        onSearch?()
    }
}
