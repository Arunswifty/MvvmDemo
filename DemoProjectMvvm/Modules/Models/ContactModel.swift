//
//  ContactModel.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 17/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

@objcMembers class StoreContact: Object, Codable {
    dynamic var id = 0
    dynamic var firstName: String?
    dynamic var lastName: String?
    dynamic var companyName: String?
    dynamic var gender: String?
    dynamic var aboutCompany: String?
    dynamic var phoneNumber: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case companyName = "companyName"
        case gender = "gender"
        case aboutCompany = "About"
        case phoneNumber = "phoneNu"
    }
    
    func getAllData() -> Results<StoreContact> {
        return RObject.objects(StoreContact.self)
    }
    
    func distinct(stat: Section)-> Results<StoreContact> {
        switch stat {
        case .gender:
            return getAllData().distinct(by: ["gender"])
        case .companyName:
            return getAllData().distinct(by: ["companyName"])
        }
    }
}
