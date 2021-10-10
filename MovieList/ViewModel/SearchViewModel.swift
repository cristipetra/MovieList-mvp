//
//  SearchViewModel.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import Foundation
import Combine
import Model

protocol SearchViewModelContract {
    var title: String { get }
    var movies: [Movie] { set get }
    //var searchBarDidChanged: String
    func didSearchBarChanged(text: String)
}

class SearchViewModel: SearchViewModelContract {
    var title: String { return "Search" }
    
    func didSearchBarChanged(text: String) {
        searchText = text
    }
    
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    private var cancelables: Set<AnyCancellable> = []
    
    
    let services: GenericMovieProvider
    
    init(_ services: GenericMovieProvider = MovieServiceProvider()) {
        self.services = services
        addListener()
    }
    
    func addListener() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { val in
                print("val")
                print(val)
                //if val.count < 3 { return nil }
                //return val
                if val.count > 2 {
                    self.searchMovies(title: val)
                }
            }
            .sink { val1 in
                print("val1")
                print(val1)
            }
            .store(in: &cancelables)
    }
    
    func searchMovies(title: String) {
        services.searchMovie(with: title)
            .sink { val in
                
            } receiveValue: { movies in
                print("---------")
                print(movies)
            }.store(in: &cancelables)

            
    }
}
