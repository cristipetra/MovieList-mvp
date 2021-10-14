//
//  PlaceholderStatus.swift
//  MovieList
//
//  Created by Cristian Petra on 13.10.2021.
//

import Foundation

enum PlaceholderStatusType {
    case empty
    case error
}

struct PlaceholderStatus {
    let type: PlaceholderStatusType
    let title: String
    
    static func defaultEmpty() -> PlaceholderStatus {
        return PlaceholderStatus(type: .empty, title: "There are no movies yet.")
    }
    
    static func defaultError() -> PlaceholderStatus {
        return PlaceholderStatus(type: .error, title: "There has been an error. Try again.")
    }
}
