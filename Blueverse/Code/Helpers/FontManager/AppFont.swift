//
//  AppFont.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

struct AppFont {
    
    static func getFont(_ fontType: FontType) -> UIFont {
        return UIFont(name: fontType.name, size: fontType.size) ??
            .avenirNextMedium(fontType.size)
    }
    
}
