//
//  File.swift
//  
//
//  Created by Cristian Petra on 06.10.2021.
//

import Foundation
import Alamofire

public final class CoreService {
    static let shared: CoreService = CoreService()
    
    static let apiVer: String = "/3"
    
    func baseURL() -> String {
        "https://api.themoviedb.org"
    }
    
    public static let imageBaseStr: String = "https://image.tmdb.org/t/p/w500"
}



//class Session: Alamofire.Session {
//    static let shared: Session = {
//        let configuration = URLSessionConfiguration.default
//        let manager = Session(configuration: configuration)
//    }
//}
