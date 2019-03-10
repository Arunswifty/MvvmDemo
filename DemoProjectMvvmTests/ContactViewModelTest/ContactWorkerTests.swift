//
//  WorkerTestCase.swift
//  DemoProjectMvvmTests
//
//  Created by ArunSwifty on 24/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
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
