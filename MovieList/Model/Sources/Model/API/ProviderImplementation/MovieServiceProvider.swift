//
//  File.swift
//  
//
//  Created by Cristian Petra on 08.10.2021.
//

import Foundation
import Alamofire
import Combine

public class MovieServiceProvider: GenericMovieProvider {
    
    public init() { }
    
    public func getMovies() -> [Movie] {
        return []
    }
    
    public func searchMovie(with title: String) -> Future<[Movie], Error> {
                
        let r1 = Session.default.request(MovieServiceRouter.search("fda"))
        
        let router = MovieServiceRouter.search("forest")
        print(router)
        
        return Future<[Movie], Error> { promise in
        
        AF.request(router)
            .responseDecodable(of: GetClientsResponse.self) { result in
                print(result)
            
                guard let resp = result.value else { return }
            
                promise(.success(resp.results))
            }
        
        }
        
        //return []
    }
    
}
