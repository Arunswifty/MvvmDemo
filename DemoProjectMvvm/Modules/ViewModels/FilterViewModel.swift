//
//  FilterViewModel.swift
//  DemoProjectMvvm
//
//  Created by Arun-Swifty on 22/01/19.
//  Copyright © 2019 Arun-Swifty. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class FilterViewModel {
    var filterModel = FilterSecModel()
    var realmModel = StoreContact()
    
    var filterGender: [String] = []
    var filterCompany: [String] = []
    
    func loadData(completion: @escaping() -> Void) {
        filterModel.addSection()
    }
    
    func numberOfSection() -> Int {
        return filterModel.section.count
    }
    
    func setUpSectionTitle(section: Int) -> String {
        let getTitle = filterModel.section[section]
        return getTitle
    }
    
    func getDatas(section: Section)-> Results<StoreContact> {
        return realmModel.distinct(stat: section)
    }
    
    func appendData(section: Section, dataStore: StoreContact, didSelectRow: Bool) {
        switch didSelectRow {
        case true:
            guard section == .gender else {
                filterCompany.append(dataStore.companyName ?? "")
                return
            }
            
            filterGender.append(dataStore.gender ?? "")
            
        case false:
            guard section == .gender else {
                let index = filterCompany.firstIndex(of: dataStore.companyName ?? "")
                filterCompany.remove(at: index ?? -1)
                return
            }
            
            let index = filterGender.firstIndex(of: dataStore.gender ?? "")
            filterGender.remove(at: index ?? -1)
        }
    }
    
    func applyFilter(completion:@escaping(Results<StoreContact>) -> Void) {
        let filterCom = realmModel.getAllData().filter("(companyName IN %@)", filterCompany)
        let filterGen = realmModel.getAllData().filter("(gender IN %@)", filterGender)
        
        let filterData = filterCom.filter("(gender IN %@)", filterGender)
        
        if filterData.count > 0 {
            completion(filterData)
        } else if filterCom.count > 0 {
            completion(filterCom)
        } else {
            completion(filterGen)
        }
    }
}
