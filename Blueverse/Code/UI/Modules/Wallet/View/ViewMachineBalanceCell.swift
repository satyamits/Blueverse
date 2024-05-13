//
//  ViewMachineBalanceCell.swift
//  NewsApp
//
//  Created by Satyam Singh on 09/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

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
    @IBOutlet weak var inrSymbolText: UILabel!
    @IBOutlet weak var creditBalance: UILabel!
    @IBOutlet weak var rechargeAlertStack: UIStackView!
    @IBOutlet weak var blueverseCreditsText: UILabel!
    @IBOutlet weak var balanceText: UILabel!
    @IBOutlet weak var displayBalanceStack: UIStackView!
    @IBOutlet weak var sectionText: UILabel!
    @IBOutlet weak var transactionsView: UIView!
    @IBOutlet weak var balanceTextLabel: UILabel!
    @IBOutlet weak var taxLabelText: UILabel!
    @IBOutlet weak var viewTransactionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configure(_ item: Any?) {
        if let item = item as? ViewMachineBalanceListCellModel {
            
            
        }
    }

    
    
}
