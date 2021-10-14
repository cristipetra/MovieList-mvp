//
//  FavoritesCellView.swift
//  MovieList
//
//  Created by Cristian Petra on 10.10.2021.
//

import UIKit
import Reusable
import Model
import Kingfisher

class FavoritesCellView: UITableViewCell, NibReusable {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func setMovie(_ movie: Movie) {
        
        self.lblTitle.text = movie.originalTitle
        self.lblDescription.text = movie.overview
        self.lblRating.text = "\(movie.voteAverage)"
        
        self.imageMovie.set(imageUrl: movie.image, placeholder: nil)
    }
    
    internal func setMovie(_ movie: MovieCoreData) {
        self.lblTitle.text = movie.originalTitle ?? ""
        self.lblDescription.text = movie.overview
        self.lblRating.text = "\(movie.voteAverage)"
        
        if let posterPath = movie.posterPath, let url = URL(string: CoreService.imageBaseStr + posterPath) {
            self.imageMovie.set(imageUrl: url)
        }
    }

}
