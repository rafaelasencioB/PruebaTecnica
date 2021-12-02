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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureTable()
        loadData()
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func loadData() {
        movies.append(Movie(imdbID: "1", Title: "title 1", Year: "2000"))
        movies.append(Movie(imdbID: "2", Title: "title 2", Year: "2001"))
        movies.append(Movie(imdbID: "3", Title: "title 3", Year: "2002"))
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "movie \(indexPath.row)"
        return cell
    }
}
