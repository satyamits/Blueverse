//
//  ViewMachineBalanceController.swift
//  Blueverse
//
//  Created by Satyam Singh on 09/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

protocol ViewMachineBalanceListVCProtocol: AnyObject {
    func fetchMachines()
    func fetchWalletHistory()
    func fetchMachineTransactions()
    func numberOfRows(in section: Int) -> Int
    var numberOfSection: Int { get }
    func item(at indexPath: IndexPath) -> Any?
    func fetchMachineTransaction()
}

class ViewMachineBalanceListViewController: UIViewController {
    @IBOutlet weak var backArrowView: UIView!
    @IBOutlet weak var viewMachineBalanceHeaderView: UIView!
    @IBOutlet weak var backArrowIconImage: UIImageView!
    @IBOutlet weak var machineBalanceNavView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMachineBalanceText: UILabel!
    
    var disposable = CompositeDisposable([])
    var navigationStack: [UIViewController] = []
  
    var viewModel: ViewMachineBalanceListVCProtocol!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        self.viewModel = ViewMachineBalanceListViewModel(view: self)
        self.registerTableView()
        self.configureTableView()
        self.viewModel.fetchMachineTransactions()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backArrowTapped))
        backArrowView.addGestureRecognizer(tapGesture)
        self.viewModel.fetchWalletHistory()

    }
    
    @objc func backArrowTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.registerCell(ViewMachineBalanceListCell.self)
    }
    
    func configureTableView() {
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
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
    
    func reload() {
        self.tableView.reloadData()
    }
}
