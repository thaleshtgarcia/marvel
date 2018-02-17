//
//  SuperHeroTableViewController.swift
//  Marvel
//
//  Created by thales.garcia on 11/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

protocol SuperHeroListDelegate: class {
    func select(superHero: SuperHeroDTO)
}

class SuperHeroTableViewController: UITableViewController {
    
    var searchController: UISearchController =  UISearchController(searchResultsController: nil)
    var viewModel: SuperHeroViewModel?
    var isLoadingPage: Bool = false
    var isSearching: Bool = false
    
    weak var heroDelegate: SuperHeroListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Super Heroes"
        setupTableView()
        setupSearchController()
        showLoading()
        viewModel?.loadSuperHeroes {
            DispatchQueue.main.async { [weak self] in
                self?.hideLoading()
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupViewController(delegate: SuperHeroListDelegate?, viewModel: SuperHeroViewModel) {
        self.heroDelegate = delegate
        self.viewModel = viewModel
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 131
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your Super Hero"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //MARK: Search Controller
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

//MARK: - UITableViewControlleDataSource
extension SuperHeroTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        let dataSource = isSearching ? viewModel?.searchSuperHeroes : viewModel?.superHeroes
        
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuperHeroTableViewCell") as? SuperHeroTableViewCell else {
            return UITableViewCell()
        }
        
        var dataSource = isSearching ? viewModel?.searchSuperHeroes : viewModel?.superHeroes

        guard let superHero = dataSource?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.tag = indexPath.row
        cell.accessoryType = .disclosureIndicator
        cell.delegate = self
        cell.setup(with: superHero) { image in
            DispatchQueue.main.async {
                if (cell.tag == indexPath.row) {
                    cell.setImage(image)
                }
            }
        }
        return cell
    }
}

extension SuperHeroTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            guard let superHero = viewModel?.searchSuperHeroes[indexPath.row] else {
                return
            }
            heroDelegate?.select(superHero: superHero)
        } else {
            guard let superHero = viewModel?.superHeroes[indexPath.row] else {
                return
            }
            heroDelegate?.select(superHero: superHero)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let heroesCounter = viewModel?.superHeroes.count else {
            return
        }
        
        if indexPath.row >= (heroesCounter - 1) && !isLoadingPage {
            let footerView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            footerView.startAnimating()
            tableView.tableFooterView = footerView
            isLoadingPage = true
            viewModel?.loadNextPage {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoadingPage = false
                    self?.tableView.reloadData()
                    self?.tableView.tableFooterView = nil
                }
            }
        }
    }
}

extension SuperHeroTableViewController: LoadImageDelegate {
    
    func load(imageURL: String?, completion: @escaping (UIImage?) -> Void) {
        viewModel?.loadImage(with: imageURL) { imageData in
            guard let image = imageData, let imageObject = UIImage(data: image) else {
                completion(nil)
                return
            }
            completion(imageObject)
        }
    }
}

extension SuperHeroTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SuperHeroTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        showLoading()
        viewModel?.loadSuperHeroes {
            DispatchQueue.main.async { [weak self] in
                self?.hideLoading()
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        isSearching = true
        showLoading()
        viewModel?.searchSuperHero(by: searchText, completion: {
            DispatchQueue.main.async { [weak self] in
                self?.hideLoading()
                self?.tableView.reloadData()
            }
        })
    }
}
