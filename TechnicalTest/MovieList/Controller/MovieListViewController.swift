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
    private var page = 1
    private let reuseIdentifier = "MovieCell"
    
    private var movies = [Movie]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var searchController: UISearchController!
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
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search movie by title"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func resetPagination() {
        self.page = 1
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
        searchController.isActive = false
        
        let id = self.movies[indexPath.row].imdbID
        service.fetchMovie(withId: id) { result in
            switch result {
            case .success(let movie):
                let controller = MovieDetailViewController(movie: movie)
                self.present(controller, animated: true)
            case .failure(let error):
                if error == .apiError {
                    Utils.showAlert(on: self, title: error.localizedDescription)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Clean table
        if searchBar.text == "" {
            self.movies.removeAll()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.movies.removeAll()
    }
}

//MARK: UISearchResultsUpdating
extension MovieListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        resetPagination()
        
        //Make search when text to seach is not empty and longer than 2 characters
        guard let title = searchController.searchBar.text, !title.isEmpty, title.count > 2 else {
            return
        }
        
        service.fetchMovies(pagination: false, page: page, withTitle: title) { result in
            switch result {
                
            case .success(let movies):
                self.movies = movies.result
            case .failure(let error):
                if error == .apiError {
                    Utils.showAlert(on: self, title: error.localizedDescription)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension MovieListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (self.tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
            guard !service.isPaginating else { return }
            
            page += 1
            service.fetchMovies(pagination: true, page: page, withTitle: searchText) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let moreMovies):
                    self.movies.append(contentsOf: moreMovies.result)
                case .failure(let error):
                    if error == .apiError {
                        Utils.showAlert(on: self, title: error.localizedDescription)
                    } else {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }
}
