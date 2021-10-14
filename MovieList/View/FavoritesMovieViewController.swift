//
//  FavoritesMovieViewController.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import UIKit
import Reusable
import Combine

class FavoritesMovieViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: FavoritesViewModelContract!
    
    var cancellables: Set<AnyCancellable> = []
    
    // actions
    var onSearch: DoneHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(cellType: FavoritesCellView.self)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(handlerSearch))
        
        // show/hide placeholder for a table
        viewModel.placeholder
            .sink { placeholderStatus in
                if let placeholderStatus = placeholderStatus {
                    self.tableView.tableFooterView = self.placeholderView(with: placeholderStatus)
                } else {
                    self.tableView.tableFooterView = UIView()
                }
            }
            .store(in: &cancellables)
        
        viewModel.onReload = {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchMovies()
    }
    
}

// MARK: - table view delegates
extension FavoritesMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoritesCellView = tableView.dequeueReusableCell(for: indexPath)
        cell.setMovie(viewModel.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


// MARK: - actions
extension FavoritesMovieViewController {
    @objc func handlerSearch() {
        onSearch?()
    }
}

