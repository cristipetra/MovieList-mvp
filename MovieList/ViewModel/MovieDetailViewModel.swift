//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Cristian Petra on 10.10.2021.
//

import Foundation
import Model

protocol MovieDetailViewModelContract {
    var movie: Movie { get }
    var rating: String { get }
    var title: String { get }
    var description: String { get }
    func addToFavorites()
    func hideFromSearch()
    var onSavedMovie: DoneHandler? { get }
}

class MovieDetailViewModel: MovieDetailViewModelContract {
    var movie: Movie
    var rating: String { "Rating: \(movie.voteAverage)" }
    var title: String { movie.originalTitle }
    var description: String { movie.overview }
    
    let storageProvider = StorageProvider()
    
    var onSavedMovie: DoneHandler?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func addToFavorites() {
        storageProvider.saveMovie(movie: movie)
        self.onSavedMovie?()
    }
    
    func hideFromSearch() {
        storageProvider.saveMovie(movie: movie, hideFromFutureSearch: true)
        onSavedMovie?()
    }
}
