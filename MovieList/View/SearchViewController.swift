//
//  SearchViewController.swift
//  MovieList
//
//  Created by Cristian Petra on 09.10.2021.
//

import UIKit

class SearchViewController: UIViewController {
    var viewModel: SearchViewModelContract!

    @IBOutlet weak var searchBarMovie: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarMovie.delegate = self
        
        //searchBarMovie.searchTextField.textp
        
        list()
        
        bindViewModel()
    }
    
    func list() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBarMovie.searchTextField)
        
        publisher.sink { val in
            print(val)
        }
        
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        
        viewModel.didSearchBarChanged(text: searchText)
    }
}



extension SearchViewController {
    internal func bindViewModel() {
        self.title = viewModel.title
    }
}


