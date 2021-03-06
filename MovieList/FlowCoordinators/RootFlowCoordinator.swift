//
//  RootFlowCoordinator.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import Foundation
import UIKit
import Model

typealias DoneHandler = (() -> Void)

protocol FlowCoordinator {
    func present()
    func dismiss(completion: @escaping() -> Void)
}

final class RootFlowCoordinator: FlowCoordinator {
    private let parent: UIViewController
    private var navigation: UINavigationController!
    
    private var favoritesVC: FavoritesMovieViewController!
    private var favoritesViewModel: FavoritesViewModel!
    
    init(parent: UIViewController) {
        self.parent = parent
        
        initFavorites()
    }
    
   private func initFavorites() {
        favoritesVC = UIStoryboard.main.favoritesScren()
        favoritesVC.modalPresentationStyle = .fullScreen
        
        favoritesViewModel = FavoritesViewModel()
        favoritesVC.viewModel = favoritesViewModel
       
       favoritesVC.onSearch = {
           self.presentSearchScreen()
       }
    }
    
    private func presentSearchScreen() {
        let searchVC: SearchViewController = UIStoryboard.main.searchScreen()
        let searchViewModel = SearchViewModel()
        searchVC.viewModel = searchViewModel
                
        searchViewModel.didSelectMovie = { movie in
            
            self.presentDetailScreen(movie: movie)
        }
        
        self.navigation.pushViewController(searchVC, animated: true)
    }
    
    private func presentDetailScreen(movie: Movie) {
        let movieDetailVC: MovieDetailViewController = UIStoryboard.main.detailScreen()
        let movieDetailViewModel = MovieDetailViewModel(movie: movie)
        
        movieDetailVC.viewModel = movieDetailViewModel
        movieDetailViewModel.onSavedMovie = {
            self.favoritesViewModel.fetchMovies()
        }
        
        self.navigation.pushViewController(movieDetailVC, animated: true)
    }
    
    func present() {
        self.navigation = UINavigationController(rootViewController: favoritesVC)
        self.navigation.modalPresentationStyle = .fullScreen
        
        parent.present(navigation, animated: true, completion: nil)
    }
    
    func dismiss(completion: @escaping () -> Void) {
        
    }
}
