//
//  Movie.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import Foundation

struct Movie: Decodable {
    let imdbID: String
    let Title: String
    let Year: String
    let Poster: String?
    
    var urlImage: URL? {
        return URL(string: Poster ?? "")
    }
}

struct MovieResponse: Decodable {
    let result: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case result = "Search"
    }
}
