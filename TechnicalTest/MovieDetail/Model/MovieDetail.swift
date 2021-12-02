//
//  MovieDetail.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import Foundation

struct MovieDetail: Decodable {
    let imdbID: String, Title: String?, Year: String?, Released: String?,
        Runtime: String?, Genre: String?, Plot: String?, Poster: String?, Website: String?
    
    var urlImage: URL? {
        return URL(string: Poster ?? "")
    }
}
