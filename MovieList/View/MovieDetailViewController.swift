//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Cristian Petra on 10.10.2021.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    var viewModel: MovieDetailViewModelContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let url = viewModel.movie.image {
            self.imagePoster.set(imageUrl: url)
        }
        self.lblTitle.text = viewModel.title
        self.lblDescription.text = viewModel.description
        self.lblRating.text = viewModel.rating
    }
    
}

// MARK: - actions
extension MovieDetailViewController {
    @IBAction func handlerRemoveFromSearch(_ sender: Any) {
        viewModel.hideFromSearch()
    }
    
    @IBAction func handlerAddToFavorites(_ sender: Any) {
        viewModel.addToFavorites()
    }
}
