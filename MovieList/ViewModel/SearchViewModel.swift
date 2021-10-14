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
    
    var onChangedMovies: DoneHandler? { set get }
    var didSelectMovie: ((Movie) -> Void)? { set get }
    
    var isLoading: PassthroughSubject<Bool, Never> { set get }
    var placeholder: CurrentValueSubject<PlaceholderStatus?, Never> { set get }
    
    func didSearchBarChanged(text: String)
}

class SearchViewModel: SearchViewModelContract {
    
    var title: String { return "Search" }
        
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    
    var hiddenMovies: [MovieCoreData] = []
    let storageProvider = StorageProvider()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var placeholder: CurrentValueSubject<PlaceholderStatus?, Never> = .init(nil)
    
    private var cancelables: Set<AnyCancellable> = []
    
    var onChangedMovies: DoneHandler?
    var didSelectMovie: ((Movie) -> Void)?
    
    let services: GenericMovieProvider
    
    init(_ services: GenericMovieProvider = MovieServiceProvider()) {
        self.services = services
        addListener()
    }
    
    func addListener() {
        hiddenMovies = storageProvider.getHiddenMovies()
        
        $searchText
            .debounce(for: .milliseconds(800), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { val in
                if val.count > 2 {
                    self.searchMovies(title: val)
                }
            }
            .sink { val in }
            .store(in: &cancelables)
    }
    
    func didSearchBarChanged(text: String) {
        searchText = text
    }
    
    func searchMovies(title: String) {
        self.isLoading.send(true)
        services
            .searchMovie(with: title)
            .sink { completion in
                print(completion)
                self.isLoading.send(false)
                self.placeholder.send(PlaceholderStatus.defaultError())
            } receiveValue: { movies in
                self.isLoading.send(false)
                
                let allIds = self.hiddenMovies.map { $0.id }.compactMap {  Int($0) }
                let filteredMovies = movies.filter { !allIds.contains($0.id) }
                
                self.movies = filteredMovies
                
                if filteredMovies.isEmpty {
                    self.placeholder.send(PlaceholderStatus(type: .empty, title: "No movie found! Try with different name."))
                } else {
                    self.placeholder.send(nil)
                }
                
                self.onChangedMovies?()
            }
            .store(in: &cancelables)
    }
    
}
