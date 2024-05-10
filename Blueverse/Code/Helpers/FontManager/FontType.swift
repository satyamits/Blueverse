//
//  FontType.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import Foundation

enum FontType {
    
    case h1
    case h2
    
    var name: String {
        switch self {
        case .h1, .h2:
            return "AvenirNext-Medium"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .h1:
            return 24
        case .h2:
            return 20
        }
    }
}
