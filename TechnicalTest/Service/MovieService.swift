//
//  MovieService.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import Foundation

protocol MovieService {
    func fetchMovies(withTitle title: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
    func fetchMovie(withId id: String, completion: @escaping (Result<Movie, MovieError>) -> Void)
}
