//
//  FavoritesViewModel.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import Foundation
import Combine

protocol FavoritesViewModelContract {
    var storageProvider: StorageProvider { set get }
    var movies: [MovieCoreData] { set get }
    var placeholder: CurrentValueSubject<PlaceholderStatus?, Never> { set get }
    
    var onReload: DoneHandler? { set get }
    func fetchMovies() 
}

class FavoritesViewModel: FavoritesViewModelContract {

    var storageProvider: StorageProvider
    
    var movies: [MovieCoreData] = []
    var placeholder = CurrentValueSubject<PlaceholderStatus?, Never>(nil)
    var onReload: DoneHandler?
    
    init() {
        self.storageProvider = StorageProvider()
    }
    
    func fetchMovies() {
        self.movies = storageProvider.getFavoritesMovies()
        
        if self.movies.isEmpty {
            placeholder.send(PlaceholderStatus.defaultEmpty())
        } else {
            placeholder.send(nil)
        }
        self.onReload?()
    }
    
}
