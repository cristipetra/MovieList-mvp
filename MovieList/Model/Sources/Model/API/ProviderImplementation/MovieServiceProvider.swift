//
//  File.swift
//  
//
//  Created by Cristian Petra on 08.10.2021.
//

import Foundation
import Alamofire
import Combine

public enum APIError: Error {
    case unknown
    case description(String)
}

public class MovieServiceProvider: GenericMovieProvider {
    
    public init() { }
    
    public func getMovies() -> [Movie] {
        return []
    }
    
    public func searchMovie(with title: String) -> Future<[Movie], APIError> {
        let router = MovieServiceRouter.search(title)
        return Future<[Movie], APIError> { promise in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                return promise(.failure(.unknown))
//            }
            
            AF.request(router)
                .responseDecodable(of: GetClientsResponse.self) { result in
                    //print(result)
                    switch result.result {
                    case .failure(let error):
                        return promise(.failure(.description(error.localizedDescription)))
                    case .success(let clientsResponse):
                        return promise(.success(clientsResponse.results))
                    }
                }
        }
    }
    
}
