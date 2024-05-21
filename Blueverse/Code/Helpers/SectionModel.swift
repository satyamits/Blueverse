//
//  SectionModel.swift
//  Blueverse
//
//  Created by Satyam Singh on 20/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation

 public class SectionModel {
    var header: Any?
    var cellModels: [Any]
    var footer: Any?
    
    init(header: Any?, cellModels: [Any], footer: Any?) {
        self.header = header
        self.cellModels = cellModels
        self.footer = footer
    }
}
