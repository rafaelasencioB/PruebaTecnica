//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import UIKit

class MovieListViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    private let reuseIdentifier = "MovieCell"
    
    private var movies = [Movie]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController()
    private let service: MovieService = MovieLoader.shared
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: Helpers
    private func configure() {
        configureSearchController()
        configureTable()
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search movie by title"
        searchController.searchResultsUpdater = self
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let id = self.movies[indexPath.row].imdbID
        service.fetchMovie(withId: id) { result in
            switch result {
            case .success(let movie):
                let controller = MovieDetailViewController(movie: movie)
                self.present(controller, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK:
extension MovieListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let title = searchController.searchBar.text, !title.isEmpty, title.count > 2 else {
            if let text = searchController.searchBar.text, text.isEmpty && self.movies.count > 0 {
                self.movies = []
            }
            return
        }
        
        service.fetchMovies(withTitle: title) { result in
            switch result {
                
            case .success(let movies):
                self.movies = movies.result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
