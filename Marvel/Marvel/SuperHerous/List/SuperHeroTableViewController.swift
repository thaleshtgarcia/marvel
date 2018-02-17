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
    
    var viewModel: SuperHeroViewModel?
    var isLoadingPage: Bool = false
    weak var heroDelegate: SuperHeroListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Super Heroes"
        viewModel?.loadSuperHeroes {
            DispatchQueue.main.async { [weak self] in
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
}

//MARK: - UITableViewControlleDataSource
extension SuperHeroTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        return viewModel?.superHeroes.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuperHeroTableViewCell") as? SuperHeroTableViewCell,
            let superHero = viewModel?.superHeroes[indexPath.row] else { return UITableViewCell() }
        
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
        guard let superHero = viewModel?.superHeroes[indexPath.row] else {
            return
        }
        
        heroDelegate?.select(superHero: superHero)
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
