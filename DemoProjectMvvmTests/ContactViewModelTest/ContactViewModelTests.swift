//
//  ContactViewModelTest.swift
//  DemoProjectMvvmTests
//
//  Created by Arun-Swifty on 24/01/19.
//  Copyright © 2019 Arun-Swifty. All rights reserved.
//

import XCTest
import RealmSwift
import Realm
@testable import DemoProjectMvvm

class ContactViewModelTests: XCTestCase {
    
    var viewContactModel = ContactViewModel()
    
    override func setUp() {
        viewContactModel.dataParsing { (status) in
            guard status == true else { return }
            XCTAssert(status)
        }
    }

    func testFilterMale() {
        let getObject = RObject.objects(StoreContact.self).filter({$0.gender == "Male"})
        
        XCTAssert(getObject[0].gender ?? "" == "Male")
        XCTAssert(getObject[1].gender ?? "" == "Male")
        XCTAssert(getObject[2].gender ?? "" == "Male")
    }
    
    func testPersistenceData() {
        let resultExpectation = expectation(description: "contains")
        
        viewContactModel.dataParsing { [weak self] (_) in
            let contactsList = self?.viewContactModel.contactsData
            
            guard contactsList?.count ?? -1 > 0 else { return }
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testDeleteIndex() {
        let deleteExpectation = expectation(description: "index")
        
        viewContactModel.dataParsing { [weak self] (_) in
            
            guard let contactsList = self?.viewContactModel.contactsData else { return }
            
            let getCount = contactsList.count
            
            self?.viewContactModel.deleteSelectedRows(index: [0], storeData: contactsList[0], completion: {
                if getCount > contactsList.count {
                    deleteExpectation.fulfill()
                } else {
                    XCTFail("Failed")
                }
            })
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInsertDataifNotExists() {
        let promiseExpectation = expectation(description: "insert")
        viewContactModel.deleteAll()
        
        viewContactModel.dataParsing { [weak self] (_) in
            guard self?.viewContactModel.contactsData?.count ?? -1 > 0 else {
                XCTFail("Failed to insert")
                return
            }
            promiseExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
