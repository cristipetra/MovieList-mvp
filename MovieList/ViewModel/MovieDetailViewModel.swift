//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Cristian Petra on 10.10.2021.
//

import Foundation
import Model
import Combine

protocol MovieDetailViewModelContract {
    var movie: Movie { get }
    var rating: String { get }
    var title: String { get }
    var description: String { get }
    
    func addToFavorites()
    func hideFromSearch()
    
    var isEnabledAdd: CurrentValueSubject<Bool, Never> { set get }
    var onSavedMovie: DoneHandler? { get }
    var onMessage: ((String) -> Void)? { set get }
}

class MovieDetailViewModel: MovieDetailViewModelContract {
    var movie: Movie
    var rating: String { "Rating: \(movie.voteAverage)" }
    var title: String { movie.originalTitle }
    var description: String { movie.overview }
    
    let storageProvider = StorageProvider()
    
    var onSavedMovie: DoneHandler?
    var onMessage: ((String) -> Void)?
    
    
    var isEnabledAdd: CurrentValueSubject<Bool, Never> = .init(true)
    
    init(movie: Movie) {
        self.movie = movie
        
        
        storageProvider.getFavoritesMovies { movies in
            if movies.map { $0.id }.compactMap{ Int($0) }.contains(self.movie.id) {
                self.isEnabledAdd.send(false)
            }
        }
        
    }
    
    func addToFavorites() {
        
        storageProvider.saveMovie(movie: movie) {
            self.onSavedMovie?()
            self.isEnabledAdd.send(false)
            self.onMessage?("Movie successfully added.")
        }
    }
    
    func hideFromSearch() {
        storageProvider.saveMovie(movie: movie, hideFromFutureSearch: true) {
            onSavedMovie?()
            self.onMessage?("Movie successfully remove from search.")
        }
    }
}
