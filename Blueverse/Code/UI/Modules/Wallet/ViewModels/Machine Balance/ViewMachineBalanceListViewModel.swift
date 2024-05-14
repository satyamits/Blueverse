//
//  ViewMachineBalanceListViewModel.swift
//  NewsApp
//
//  Created by Satyam Singh on 09/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import Model    

protocol ViewMachineBalanceListViewModelProtocol:
    AnyObject {
    func reload()
    func fetchMachineTransactions()
}

class ViewMachineBalanceListViewModel {
    
    weak var view: ViewMachineBalanceListViewModelProtocol?
    
    let walletData: [Machine] = []
    
    var sectionModels: [SectionModel] = []
    
    init(view: ViewMachineBalanceListViewModelProtocol?) {
        self.view = view
    }
    
    func prepareCellModels() {
        
        let cellModels = self.walletData.map({ViewMachineBalanceListCellModel(machineData: $0)})
        
        self.sectionModels = [SectionModel(header:nil, cellModels: cellModels, footer: nil)]
        self.view?.reload()
    }
    
    func fetchMachineTransactions() {
        self.prepareCellModels()
    }
}


extension ViewMachineBalanceListViewModel: ViewMachineBalanceListViewControllerProtocol {
    
    
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
