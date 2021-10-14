//
//  File.swift
//  
//
//  Created by Cristian Petra on 06.10.2021.
//

import Foundation
import Combine

public protocol GenericMovieProvider {
    func getMovies() -> [Movie]
    func searchMovie(with title: String) -> Future<[Movie], APIError>
}
