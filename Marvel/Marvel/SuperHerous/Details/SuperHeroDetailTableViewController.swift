//
//  SuperHeroDetailTableViewController.swift
//  Marvel
//
//  Created by thales.garcia on 15/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation
import UIKit

class SuperHeroDetailTableViewController: UITableViewController {
    var viewModel: SuperHeroDetailViewModel?
    
    // Tuple to manage the requests 
    var flagControl: (Bool, Bool, Bool, Bool) = (false, false, false, false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.superHero.details?.name
        setupTableView()
        loadCollections()
    }
    
    //MARK: Private Methods
    private func loadCollections() {
        viewModel?.loadComicsCollection { [weak self] in
            DispatchQueue.main.async {
                self?.flagControl.0 = true
                self?.reloadTableView()
            }
        }
        viewModel?.loadEventsCollection { [weak self] in
            DispatchQueue.main.async {
                self?.flagControl.1 = true
                self?.reloadTableView()
            }
        }
        viewModel?.loadStoriesCollection { [weak self] in
            DispatchQueue.main.async {
                self?.flagControl.2 = true
                self?.reloadTableView()
            }
        }
        viewModel?.loadSeriesCollection { [weak self] in
            DispatchQueue.main.async {
                self?.flagControl.3 = true
                self?.reloadTableView()
            }
        }
    }
    
    private func reloadTableView() {
        if flagControl == (true, true, true, true) {
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 131
    }
}

//MARK: - UITableViewControlleDataSource
extension SuperHeroDetailTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        super.numberOfSections(in: tableView)
        return viewModel?.numberOfSections ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        
        guard let viewModelObject = viewModel else { return 0 }
        
        let cellType = viewModelObject.cells[section]
        return viewModelObject.numberOfRows(type: cellType)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        
        let cellType = viewModel?.cells[indexPath.section]
        let cellReturned = self.cell(tableView, index: indexPath.row, from: cellType)

        return cellReturned
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let cellType = viewModel?.cells[section] else {
            return ""
        }
        
        return cellType.rawValue
    }
    
    private func cell(_ tableView: UITableView, index: Int, from cellType: SuperHeroDetailCellType?) -> UITableViewCell {
        
        guard let type = cellType else {
            return UITableViewCell()
        }
        
        switch type {
            case .superHeroDetail:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuperHeroDetailTableViewCell") as? SuperHeroDetailTableViewCell,
                let details = viewModel?.superHero else { return UITableViewCell() }
                
                cell.delegate = self

                let isFavourite = viewModel?.isFavouriteSuperHero(superHero: details.details) ?? false
                cell.setup(superHero: details, isFavourite: isFavourite)
                
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as? CollectionTableViewCell,
                    let items = viewModel?.collection(forType: type) else { return UITableViewCell() }
                
                let item = items[index]
                cell.setup(with: item)
                return cell
        }
    }
}

extension SuperHeroDetailTableViewController: SuperHeroDetailTableViewCellDelegate {
    func favouriteSuperHero(superHero: SuperHeroDTO?, isFavourite: Bool) {
        viewModel?.favouriteSuperHero(superHero: superHero, isFavourite: isFavourite)
    }
    
    
}
