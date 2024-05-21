//  ViewMachineBalanceListViewModel.swift
//  Blueverse
//
//  Created by Satyam Singh on 09/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.

import Foundation
import Model
import ReactiveSwift
import JWTDecode

protocol ViewMachineBalanceListViewModelProtocol: AnyObject {
    func reload()
}

class ViewMachineBalanceListViewModel {
    
    weak var view: ViewMachineBalanceListViewModelProtocol?
    var disposable = CompositeDisposable([])
    var walletData: [Outlets] = []
    var balanceData: [WalletHistory] = []
    var dealerId = ""
    
    var sectionModels: [SectionModel] = []
    
    init(view: ViewMachineBalanceListViewModelProtocol?) {
        self.view = view
        let userData = decode(jwtToken: DataModel.shared.authToken.components(separatedBy: " ").last ?? "")
        print("JWT Token: \(userData)")
        if let userId = userData["userId"] as? String {
            self.dealerId = userId
        }
        self.setupObservers()
        self.generateDummyData()
    }
    
 // MARK: SetupObservers
    func setupObservers() {
        self.disposable += self.fetchMachinesAction.values.observeValues({ [weak self] response in
            self?.walletData = response
            dump(self?.walletData)
            self?.prepareCellModels()
        })
        self.disposable += self.fetchMachinesAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
        
        self.disposable += self.fetchWalletHistoryAction.values.observeValues({ [weak self] response in
            self?.balanceData = response
        })
        self.disposable += self.fetchWalletHistoryAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
    }
    
    let fetchMachinesAction = Action {(id: String) -> SignalProducer<[Outlets], ModelError> in
        return Outlets.fetchMachineResponse(id: id)
    }
    
    func fetchMachines() {
        self.disposable += self.fetchMachinesAction.apply(self.dealerId).start()
    }
    
    func initialSetup() {
      self.setupObservers()
    }
    
    let fetchWalletHistoryAction = Action {(params: [String: String]) -> SignalProducer<[WalletHistory], ModelError> in
        return WalletHistory.fetchWalletResponse(params: params)
    }
    
    
    /*func prepareCellModels() {
        
        let cellModels = self.walletData.map({ViewMachineBalanceListCellModel(machineData: $0)})
        
        self.sectionModels = [SectionModel(header: nil, cellModels: cellModels, footer: nil)]
        self.view?.reload()
        
    }*/
    
// MARK: PrepareCellModels
    func prepareCellModels() {
        let cellModels = self.walletData.flatMap { outlet in
            outlet.machines.map { machine in
                ViewMachineBalanceListCellModel(machineData: machine)
            }
        }
        
        self.sectionModels = [SectionModel(header: nil, cellModels: cellModels, footer: nil)]
//        self.view?.reload()
    }

    
    func fetchMachineTransactions() {
        fetchMachinesAction.apply(self.dealerId).start()
    }
    
    func fetchWalletHistory() {
        fetchWalletHistoryAction.apply(["dealerId": self.dealerId]).start()
    }
// MARK: Dummy data
    
    func generateDummyData() {
            let dummyMachines = [
                Machine(name: "Machine 1", machineGuid: "guid1", status: "active", isAssigned: true, feedbackFormId: "form1", walletbalance: 100.0, blueverseCredit: 50.0),
                Machine(name: "Machine 2", machineGuid: "guid2", status: "inactive", isAssigned: false, feedbackFormId: "form2", walletbalance: 200.0, blueverseCredit: 75.0)
            ]
            
            let dummyOutlet = Outlets(name: "Outlet 1", address: "Address 1", dealerId: "dealer1", machines: dummyMachines)
            
            self.walletData = [dummyOutlet]
            self.prepareCellModels()
        }
}

extension ViewMachineBalanceListViewModel: ViewMachineBalanceListVCProtocol {
    func fetchMachineTransaction() {

    }
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

// MARK: decoding token
extension ViewMachineBalanceListViewModel {
    
    func decode(jwtToken jwt: String) -> [String: Any] {
      let segments = jwt.components(separatedBy: ".")
      return decodeJWTPart(segments[1]) ?? [:]
    }

    func base64UrlDecode(_ value: String) -> Data? {
      var base64 = value
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

      let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
      let requiredLength = 4 * ceil(length / 4.0)
      let paddingLength = requiredLength - length
      if paddingLength > 0 {
        let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
        base64 += padding
      }
      return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    func decodeJWTPart(_ value: String) -> [String: Any]? {
      guard let bodyData = base64UrlDecode(value),
        let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
          return nil
      }

      return payload
    }
}
