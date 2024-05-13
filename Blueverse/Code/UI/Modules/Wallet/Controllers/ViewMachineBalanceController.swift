//
//  ViewMachineBalanceController.swift
//  NewsApp
//
//  Created by Satyam Singh on 09/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import UIKit

protocol ViewMachineBalanceListViewControllerProtocol: AnyObject {
    
    func fetchMachineTransactions()
    func numberOfRows(in section: Int) -> Int
    var numberOfSection: Int { get }
    func item(at indexPath: IndexPath) -> Any?
    
}

class ViewMachineBalanceListViewController: UIViewController {
    @IBOutlet weak var backArrowView: UIView!
    @IBOutlet weak var viewMachineBalanceHeaderView: UIView!
    @IBOutlet weak var backArrowIconImage: UIImageView!
    @IBOutlet weak var machineBalanceNavView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMachineBalanceText: UILabel!
    
    var navigationStack: [UIViewController] = []
    
    
    var viewModel: ViewMachineBalanceListViewControllerProtocol!
    override func viewDidLoad() {
        
    super.viewDidLoad()
        self.viewModel = ViewMachineBalanceListViewModel(view: self)
        self.registerTable()
        viewModel.fetchMachineTransactions()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backArrowTapped))
        backArrowView.addGestureRecognizer(tapGesture)

    }
    
    @objc func backArrowTapped() {
            navigateBack()
        }
        
        // Function to navigate back
        func navigateBack() {
            guard let previousViewController = navigationStack.popLast() else {
                // No previous view controller to navigate back to
                return
            }
            navigationController?.popToViewController(previousViewController, animated: true)
        }
    
    func registerTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.registerCell(ViewMachineBalanceListCell.self)
    }
    
}


extension ViewMachineBalanceListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let identifier = self.identifier(forIndexPath: indexPath),
           let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell { cell.item = self.viewModel.item(at: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func identifier(forIndexPath indexPath: IndexPath) -> String? {
        if let item = self.viewModel.item(at: indexPath) {
            switch item {
            case _ as ViewMachineBalanceListCellModel:
                 return ViewMachineBalanceListCell.reuseIdentifier
                
            default: return nil
            }
        }
        
        return nil
    }
}

// MARK: - ViewMachineBalanceListViewModelProtocol
extension ViewMachineBalanceListViewController: ViewMachineBalanceListViewModelProtocol {
    
    func fetchMachineTransactions() {
        
    }
        
    func reload() {
        self.tableView.reloadData()
    }
    
}