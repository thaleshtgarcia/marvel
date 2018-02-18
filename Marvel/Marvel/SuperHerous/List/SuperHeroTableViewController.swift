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

public extension NSNotification.Name {
    public static let superHeroFavourite: String = "superHeroFavourite"
}

class SuperHeroTableViewController: UITableViewController {
    
    var searchController: UISearchController =  UISearchController(searchResultsController: nil)
    var viewModel: SuperHeroViewModelProtocol?
    var isLoadingPage: Bool = false
    
    weak var heroDelegate: SuperHeroListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.navigationTitle ?? ""
        setupTableView()
        setupSearchController()
        showLoading()
        viewModel?.loadSuperHeroes(offset: 0, completion: {
            DispatchQueue.main.async { [weak self] in
                self?.hideLoading()
                self?.tableView.reloadData()
            }
        })
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: NSNotification.Name(rawValue: Notification.Name.superHeroFavourite),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func setupViewController(delegate: SuperHeroListDelegate?, viewModel: SuperHeroViewModelProtocol?) {
        self.heroDelegate = delegate
        self.viewModel = viewModel 
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 131
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your Super Hero"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

//MARK: - UITableViewControlleDataSource
extension SuperHeroTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        return viewModel?.dataSource.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuperHeroTableViewCell") as? SuperHeroTableViewCell,
              let superHero = viewModel?.dataSource[indexPath.row] else {
                return UITableViewCell()
        }
        
        cell.tag = indexPath.row
        cell.accessoryType = .disclosureIndicator
        cell.imageDelegate = self
        cell.delegate = self
        
        let isFavourite = viewModel?.isFavouriteSuperHero(superHero: superHero) ?? false
        cell.setup(with: superHero, isFavourite: isFavourite) { image in
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

        guard let superHero = viewModel?.dataSource[indexPath.row] else {
            return
        }
        heroDelegate?.select(superHero: superHero)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let heroesCounter = viewModel?.dataSource.count, viewModel?.isSearching == false else {
            return
        }
        
        if indexPath.row >= (heroesCounter - 1) && heroesCounter > 15 && !isLoadingPage {
            let footerView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            footerView.startAnimating()
            tableView.tableFooterView = footerView
            isLoadingPage = true
            loadNextPage {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoadingPage = false
                    self?.tableView.reloadData()
                    self?.tableView.tableFooterView = nil
                }
            }
        }
    }
    
    func loadNextPage(completion: @escaping () -> Void) {
        let offset = viewModel?.dataSource.count ?? 0
        viewModel?.loadSuperHeroes(offset: offset, completion: completion)
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

extension SuperHeroTableViewController: SuperHeroTableViewCellDelegate {
    func favouriteSuperHero(superHero: SuperHeroDTO?, isFavourite: Bool) {
        viewModel?.favouriteSuperHero(superHero: superHero, isFavourite: isFavourite)
    }
}

extension SuperHeroTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        viewModel?.isSearching = false
        showLoading()
        viewModel?.loadSuperHeroes(offset: 0) {
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
        
        viewModel?.isSearching = true
        showLoading()
        viewModel?.searchSuperHero(by: searchText, completion: {
            DispatchQueue.main.async { [weak self] in
                self?.hideLoading()
                self?.tableView.reloadData()
            }
        })
    }
}
