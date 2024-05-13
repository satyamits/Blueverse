//
//  WalletViewController.swift
//  NewsApp
//
//  Created by Satyam Singh on 08/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var walletbalanceIncGSTView: UIView!
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var balanceDividerHorizontal: UIView!
    @IBOutlet weak var walletBalanceView: UIView!
    @IBOutlet weak var leftAlignIconView: UIView!
    @IBOutlet weak var walletIconView: UIView!
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
