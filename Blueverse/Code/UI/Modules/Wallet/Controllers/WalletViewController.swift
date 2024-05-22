//
//  WalletViewController.swift
//  Blueverse
//
//  Created by Satyam Singh on 08/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Model

class WalletViewController: UIViewController {
    
  
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var selectServiceView: UIView!
    @IBOutlet weak var selectMachineView: UIView!
    @IBOutlet weak var filterDataView: UIView!
    @IBOutlet weak var downloadIconView: UIView!
    @IBOutlet weak var filterIconView: UIView!
    @IBOutlet weak var searchIconView: UIView!
    @IBOutlet weak var transactionsIconStackView: UIStackView!
    @IBOutlet weak var walletbalanceIncGSTView: UIView!
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var transactionsHistoryView: UIView!
    @IBOutlet weak var balanceDividerHorizontal: UIView!
    @IBOutlet weak var dividerView: UIView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.configureUI()
    }
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
        transactionsHistoryView.layer.cornerRadius = 8
        selectMachineView.layer.cornerRadius = 8
        selectServiceView.layer.cornerRadius = 8
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.performLogout()
        print("Logged out")
    }
    
    func performLogout() {
        DataModel.shared.clearUserData()
        print(DataModel.shared.authToken)
        navigateToLogin()
        
    }
    
    func navigateToLogin() {
        let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginPageController") as? LoginPageController
           self.navigationController?.pushViewController(vc!, animated: true)
    }
}
