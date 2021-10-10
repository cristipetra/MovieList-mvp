//
//  Storyboards.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import Foundation
import UIKit

extension UIStoryboard {
    static var main = UIStoryboard(name: "Main", bundle: nil)
    
    func favoritesScren() -> FavoritesMovieViewController {
        UIStoryboard.main.instantiateViewController(withIdentifier: "favorites") as! FavoritesMovieViewController
    }
    
    func rootScreen() -> UIViewController {
        UIStoryboard.main.instantiateViewController(withIdentifier: "root")
    }
    
    func searchScreen() -> SearchViewController {
        UIStoryboard.main.instantiateViewController(withIdentifier: "search") as! SearchViewController
    }
}
