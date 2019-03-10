//
//  ApiRouter.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 17/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import Foundation

struct StoryboardIdentifier {
    static let filterData = "FilterViewController"
    static let detailVc = "DetailViewController"
}

struct CellIdentifier {
    static let contactCell = "ContactCell"
    static let filterCell = "FilterCell"
}

struct ApiConstants {
    static let baseApi = "http://88774.mocklab.io/"
    
    static var peoplesList: String {
        return baseApi  + "peoples"
    }
}
