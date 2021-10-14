//
//  StorageProvider.swift
//  MovieList
//
//  Created by Cristian Petra on 11.10.2021.
//

import Foundation
import CoreData
import Model

class StorageProvider {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MovieCoreData")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    func saveMovie(named name: String) {
        let movie = MovieCoreData(context: persistentContainer.viewContext)
        movie.originalTitle = name
        
        do {
            try persistentContainer.viewContext.save()
            print("movie save successfully")
        } catch {
            print("Failed to save movie: \(error)")
        }
    }
        
    func saveMovie(movie: Movie, hideFromFutureSearch: Bool = false, completion: (() -> Void)) {
        
        let movieCore = MovieCoreData(context: persistentContainer.viewContext)
        movieCore.originalTitle = movie.originalTitle
        movieCore.id = Int64(movie.id)
        movieCore.voteAverage = movie.voteAverage
        movieCore.overview = movie.overview
        movieCore.isHidden = hideFromFutureSearch
        movieCore.posterPath = movie.posterPath
        
        do {
            try persistentContainer.viewContext.save()
            completion()
        } catch {
            print("Failed to save movie: \(error)")
        }
        
        
    }
}

extension StorageProvider {
    func getFavoritesMovies(completion: @escaping ([MovieCoreData]) -> Void) -> Void {
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isHidden == false")
        do {
            let items = try persistentContainer.viewContext.fetch(fetchRequest)
            completion(items)
        } catch {
            print("failed to fetch movies")
            completion([])
        }
    }
    
    
    func getFavoritesMovies() -> [MovieCoreData] {
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isHidden == false")
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("failed to fetch movies")
            return []
        }
    }
    
    func getHiddenMovies() -> [MovieCoreData] {
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isHidden == true")
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("failed to fetch movies")
            return []
        }
    }
    
    func getHiddenMovies(completion: (([MovieCoreData]) -> Void)) -> Void {
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isHidden == true")
        do {
            let items = try persistentContainer.viewContext.fetch(fetchRequest)
            completion(items)
        } catch {
            print("failed to fetch movies")
            completion([])
        }
    }
}
