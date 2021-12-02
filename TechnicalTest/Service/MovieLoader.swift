//
//  MovieLoader.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import Foundation

class MovieLoader: MovieService {
    
    private init() { }
    
    static let shared = MovieLoader()
    
    private let API_KEY = "7b6e2380"
    
    private let BASE_URL = "http://www.omdbapi.com/"
    
    private let session = URLSession.shared
    
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(withTitle title: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard let url = URL(string: BASE_URL) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["s": title], completion: completion)
    }
    
    func fetchMovie(withId id: String, completion: @escaping (Result<MovieDetail, MovieError>) -> Void) {
        guard let url = URL(string: BASE_URL) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: ["i": id, "plot": "full"], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping(Result<D, MovieError>) -> Void) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "apikey", value: API_KEY)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map({ key, value in
                URLQueryItem(name: key, value: value)
            }))
        }
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        session.dataTask(with: finalURL) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil {
                self.executeCompletionInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            guard let data = data else {
                self.executeCompletionInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let response = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionInMainThread(with: .success(response), completion: completion)
            } catch {
                self.executeCompletionInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping(Result<D, MovieError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
