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
}

struct MovieResponse: Decodable {
    let result: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case result = "Search"
    }
}
