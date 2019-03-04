//
//  FilterModel.swift
//  DemoProjectMvvm
//
//  Created by Arun-Swifty on 22/01/19.
//  Copyright © 2019 Arun-Swifty. All rights reserved.
//

import Foundation

struct FilterSecModel {
    var section = [String]()
    
    mutating func addSection() {
        section.append("Gender")
        section.append("CompanyName")
    }
}
