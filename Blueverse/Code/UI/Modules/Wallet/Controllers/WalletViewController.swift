//
//  WalletViewController.swift
//  NewsApp
//
//  Created by Satyam Singh on 08/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Model

//protocol WalletViewControllerProtocol: AnyObject {
//    func numberOfRows(in section: Int) -> Int
//    var numberOfSection: Int { get }
//    func item (at indexPath: IndexPath) -> Any?
//}

class WalletViewController: UIViewController {
    
    @IBOutlet weak var walletbalanceIncGSTView: UIView!
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var balanceDividerHorizontal: UIView!
    @IBOutlet weak var walletBalanceView: UIView!
    @IBOutlet weak var leftAlignIconView: UIView!
    @IBOutlet weak var walletIconView: UIView!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var leftAlignImage: UIImageView!
    @IBOutlet weak var manageWalletText: UILabel!
    @IBOutlet weak var creditIconView: UIView!
    @IBOutlet weak var bellIconView: UIView!
    @IBOutlet weak var viewMachinesBalanceButton: UIButton!
    @IBOutlet weak var bellIconImage: UIImageView!
    @IBOutlet weak var blueVerseCreditView: UIView!
    @IBOutlet weak var manageWalletHeaderView: UIView!
    
//    let email = "vaibhaw.anand+1@nickelfox.com"
//    let password = "Password@1"
//    let app = "DEALER"
//    var disposable = CompositeDisposable([])

//    var viewModel: WalletViewControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.registerTable()
//        self.initialSetup()
         self.configureUI()
    }
    
  /*  let fetchMachineAction = Action {(id: String) -> SignalProducer<Machine, ModelError> in
        return Machine.fetchMachineResponse(id: id)
    }
    
    func initialSetup() {
      self.setupObservers()        self.fetchMachines()
    }
    
    func setupObservers() {
        self.disposable += self.fetchMachineAction.values.observeValues({ [weak self] response in
            print(response)
        })
        self.disposable += self.fetchMachineAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
    }
    
    func fetchMachines() {
        self.disposable += self.fetchMachineAction.apply("0fdee607-b7bc-4bf0-8db9-55021059fc2c").start()
    }*/

// MARK: Register table cells
    
//   func registerTable() {
//        self.transactionTableView.delegate = self
//        self.transactionTableView.dataSource = self
//        transactionTableView.registerCell(TransactionsDetailTableViewListCell.self)
//    }
//    
    
// MARK: UIConfigurations of the views
    func configureUI() {
        walletBalanceView.layer.cornerRadius = 12
        walletBalanceView.layer.masksToBounds = true
        walletbalanceIncGSTView.layer.cornerRadius = 10
        blueVerseCreditView.layer.cornerRadius = 10
        walletIconView.layer.cornerRadius = 5
        creditIconView.layer.cornerRadius = 5
        leftAlignIconView.layer.cornerRadius = 8
        bellIconView.layer.cornerRadius = 8
    }
}



/*
 extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            case _ as TransactionsDetailsCellModel:
                 return TransactionsDetailTableViewListCell.reuseIdentifier
                
            default: return nil
            }
        }
        
        return nil
    }

}
*/
