//
//  WorkerTestCase.swift
//  DemoProjectMvvmTests
//
//  Created by Arun-Swifty on 24/01/19.
//  Copyright © 2019 Arun-Swifty. All rights reserved.
//

import XCTest
import Realm
import RealmSwift
@testable import DemoProjectMvvm

class ContactWorkerTests: XCTestCase {
    
    func testPassDataSuccess() {
        
        let expectationOutput = expectation(description: "Succeeded")
    
        ContactWorker.Fetch(urlStr: ApiConstants.peoplesList) { (codableObj: [StoreContact]) in
            
            guard codableObj.count > 0 else {
               return XCTAssert(false)
            }
            
            expectationOutput.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
