//
//  File.swift
//  
//
//  Created by Cristian Petra on 08.10.2021.
//

import Foundation

public struct Movie: Codable {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIDS: [Int]
    public let id: Int
    //let originalLanguage: OriginalLanguage
    public let originalTitle, overview: String
    public let popularity: Double
    public let posterPath: String?
    //public let releaseDate
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        //case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        //case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public var image: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: CoreService.imageBaseStr + posterPath)!
    }
}

// MARK: - GetClientsResponse
public struct GetClientsResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
