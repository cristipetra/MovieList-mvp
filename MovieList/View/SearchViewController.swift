//
//  SearchViewController.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import UIKit
import Reusable
import Combine

class SearchViewController: BaseViewController {
    var viewModel: SearchViewModelContract!

    @IBOutlet weak var searchBarMovie: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    fileprivate let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarMovie.delegate = self
        
        self.tableView.register(cellType: FavoritesCellView.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
    
        bindViewModel()
    }
    
    internal func bindViewModel() {
        self.title = viewModel.title
        
        self.viewModel.onChangedMovies = {
            self.tableView.reloadData()
        }
                
        viewModel.isLoading
            .sink { isLoading in
                if isLoading {
                    self.tableView.tableHeaderView = self.activity
                    self.activity.startAnimating()
                } else {
                    self.tableView.tableHeaderView = UIView()
                }
            }
            .store(in: &cancellables)
        
        viewModel.placeholder
            .sink { placeholderStatus in
                if let placeholderStatus = placeholderStatus {
                    self.tableView.tableFooterView = self.placeholderView(with: placeholderStatus)
                } else {
                    self.tableView.tableFooterView = UIView()
                }
            }
            .store(in: &cancellables)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearchBarChanged(text: searchText)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectMovie?(viewModel.movies[indexPath.row])
    }
}
