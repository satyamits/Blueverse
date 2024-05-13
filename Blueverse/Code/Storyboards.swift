//
//  Storyboards.swift
//  Blueverse
//
//  Created by Ravindra Soni on 11/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//


import Foundation
import FLUtilities

enum Storyboard: String {
    case main = "Main"
//    case walletViewController = "WalletViewController"
    case wallet = "Wallet"
    
    var name: String {
        return self.rawValue
    }
}

extension UIViewController {
    static var storyboardId: String {
        return self.className()
    }
}
