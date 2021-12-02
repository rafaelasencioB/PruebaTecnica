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
    private var movies = [Movie]()
    private let searchController = UISearchController()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: Helpers
    private func configure() {
        configureSearchController()
        configureTable()
        loadData()
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
    
    private func loadData() {
        movies.append(Movie(imdbID: "1", Title: "El señor de los anillos", Year: "2000"))
        movies.append(Movie(imdbID: "2", Title: "La guerra de las galaxias", Year: "2001"))
        movies.append(Movie(imdbID: "3", Title: "El curioso caso de Benjamin Button", Year: "2002"))
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
}

//MARK:
extension MovieListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty, text.count > 2 else { return }
        print(text)
    }
}
