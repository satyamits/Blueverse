//  ViewMachineBalanceCellModel.swift
//  Blueverse
//
//  Created by Satyam Singh on 09/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import Model


class ViewMachineBalanceListCellModel {
    public var machineData: Outlets
    
    init(machineData: Outlets) {
        self.machineData = machineData
    }
    var balance: [Machine] {
        return machineData.machines
    }
}
