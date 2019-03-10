//
//  ViewContactModel.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 17/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

protocol ContactViewModelProtocol: class {
    func dataLoading()
    func stopLoading()
}

class ContactViewModel {
    
    weak var delegate: ContactViewModelProtocol?
    var contactsData: Results<StoreContact>?
    
    // MARK: Fetching RealmObjects
    
    fileprivate func getRealmObject() -> Results<StoreContact> {
        return RObject.objects(StoreContact.self)
    }
    
    func deleteAll() {
        do {
            try RObject.write {
                RObject.delete(getRealmObject())
            }
        } catch {
            print(error)
        }
    }
    
    func deleteSelectedRows(index: IndexPath, storeData: StoreContact?, completion: @escaping() -> Void) {
        do {
            try RObject.write {
                if let storeData = storeData {
                    RObject.delete(storeData)
                }
            }
        } catch {
            print(error)
        }
        completion()
    }
    
    func setContact(at index: Int) -> StoreContact? {
        guard index < contactsData?.count ?? 0 else { return nil }
        let contacts = contactsData?[index]
        return contacts
    }
    
    var numberOfContacts: Int {
        return contactsData?.count ?? 0
    }
    
    func filteredData(myData: Results<StoreContact>, completion: @escaping() -> Void) {
        contactsData = myData
        completion()
    }
    
    // MARK: Fetching from Json if no objects exists
    
    func dataParsing(completion: @escaping(_ success: Bool) -> Void) {
        guard getRealmObject().count == 0 else {
            contactsData = getRealmObject()
            completion(true)
            return
        }
        
        delegate?.dataLoading()
        
        ContactWorker.Fetch(urlStr: ApiConstants.peoplesList) { [weak self] (codableObj: [StoreContact]) in
            
            do {
                try RObject.write {
                    RObject.add(codableObj.map({$0}), update: true)
                }
            } catch {
                print(error)
                completion(false)
            }
            
            guard let myData = self?.getRealmObject() else { return }
            self?.contactsData = myData
            
            self?.delegate?.stopLoading()
            
            completion(true)
        }
    }
}
