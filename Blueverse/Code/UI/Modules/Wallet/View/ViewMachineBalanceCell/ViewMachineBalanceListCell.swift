//
//  TableViewCell.swift
//  Blueverse
//
//  Created by Satyam Singh on 16/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.

import UIKit

class ViewMachineBalanceListCell: TableViewCell {
    
    @IBOutlet weak var memberLabelText: UILabel!
    @IBOutlet weak var memberIconView: UIView!
    @IBOutlet weak var balanceSectionView: UIView!
    @IBOutlet weak var displayBalanceDetailView: UIView!
    @IBOutlet weak var transactionContentView: UIView!
    @IBOutlet weak var viewBalanceCellMainView: UIView!
    @IBOutlet weak var balanceStackView: UIStackView!
    @IBOutlet weak var daysCountdownText: UILabel!
    @IBOutlet weak var blueverseCreditStack: UIStackView!
    @IBOutlet weak var balanceGSTStack: UIStackView!
    @IBOutlet weak var inrSymbolText: UILabel!
    @IBOutlet weak var creditBalance: UILabel!
    @IBOutlet weak var rechargeSuspensionChildStack: UIStackView!
    @IBOutlet weak var gstText: UILabel!
    @IBOutlet weak var monthlyAgrrementText: UILabel!
    @IBOutlet weak var monthlyAgreementView: UIView!
    @IBOutlet weak var rechargeAlertStack: UIStackView!
    @IBOutlet weak var blueverseCreditsText: UILabel!
    @IBOutlet weak var rechargeSuspensionMainStack: UIStackView!
    @IBOutlet weak var balanceText: UILabel!
    @IBOutlet weak var alertIconView: UIView!
    @IBOutlet weak var displayBalanceStack: UIStackView!
    @IBOutlet weak var sectionText: UILabel!
    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var horizontalDividerView: UIView!
    @IBOutlet weak var balanceInfoDetailView: UIView!
    @IBOutlet weak var viewtransactionsView: UIView!
    @IBOutlet weak var balanceTextLabel: UILabel!
    @IBOutlet weak var addMoneyButton: UIButton!
    @IBOutlet weak var viewTransactionButton: UIButton!
    
    override func configure(_ item: Any?) {
        if let item = item as? ViewMachineBalanceListCellModel {
            self.balanceText.text = ("\(item.machineData.walletBalance)")
            self.creditBalance.text = ("\(item.machineData.blueverseCredit)")
            self.configureUI()
        }
    }

    
    func configureUI() {
        viewBalanceCellMainView.layer.cornerRadius = 8
        viewBalanceCellMainView.layer.masksToBounds = false
        balanceInfoDetailView.layer.cornerRadius = 8
        addMoneyButton.layer.cornerRadius = 8
        memberIconView.layer.cornerRadius = 4
       
    }
}
