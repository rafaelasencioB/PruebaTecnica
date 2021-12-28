//
//  MovieService.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import Foundation

protocol MovieService {
    var pagination: Bool { get set }
    var isPaginating: Bool { get set }

    func fetchMovies(pagination: Bool, page: Int, withTitle title: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
    func fetchMovie(withId id: String, completion: @escaping (Result<MovieDetail, MovieError>) -> Void)
}
