//
//  TransactionsDetailListViewModel.swift
//  Blueverse
//
//  Created by Satyam Singh on 14/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import Model

/*protocol TransactionsDetailListViewModelProtocol:
    AnyObject {
    func reload()
    func fetchMachineTransactions()
}

class TransactionsDetailListViewModel {
    
    weak var view: TransactionsDetailListViewModelProtocol?
    
    let walletData: [Machine] = []
    
    var sectionModels: [TransactionDetailSectionModel] = []
    
    init(view: TransactionsDetailListViewModelProtocol?) {
        self.view = view
    }
    
    func prepareCellModels() {
        
        let cellModels = self.walletData.map({TransactionsDetailsCellModel(transactionData: $0)})
        
        self.sectionModels = [TransactionDetailSectionModel(header: nil, cellModels: cellModels, footer: nil)]
        self.view?.reload()
    }
    
    func fetchMachineTransactions() {
        self.prepareCellModels()
    }
}


extension TransactionsDetailListViewModel: WalletViewControllerProtocol {
    
    
    func numberOfRows(in section: Int) -> Int {
        return self.sectionModels[section].cellModels.count
    }
    
    var numberOfSection: Int {
        return self.sectionModels.count
    }
    
    func item(at indexPath: IndexPath) -> Any? {
        return self.sectionModels[indexPath.section].cellModels[indexPath.row]
    }
    
}
*/
