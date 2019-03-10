//
//  FilterModel.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 22/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import Foundation

struct FilterSecModel {
    var section = [String]()
    
    mutating func addSection() {
        section.append("Gender")
        section.append("CompanyName")
    }
}
