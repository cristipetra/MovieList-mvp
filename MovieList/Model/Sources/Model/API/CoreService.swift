//
//  File.swift
//  
//
//  Created by Cristian Petra on 06.10.2021.
//

import Foundation
import Alamofire

final class CoreService {
    static let shared: CoreService = CoreService()
    
    static let apiVer: String = "/3"
    
    func baseURL() -> String {
        "https://api.themoviedb.org"
    }
}



//class Session: Alamofire.Session {
//    static let shared: Session = {
//        let configuration = URLSessionConfiguration.default
//        let manager = Session(configuration: configuration)
//    }
//}
