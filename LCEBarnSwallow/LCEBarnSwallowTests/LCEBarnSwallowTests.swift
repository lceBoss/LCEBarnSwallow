//
//  LCEBarnSwallowTests.swift
//  LCEBarnSwallowTests
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import XCTest

@testable import LCEBarnSwallow

class LCEBarnSwallowTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let xctest = self.expectation(description: "searchImageApi")
//        SearchImageProvider.request(.imageList(keyword: "街拍", page: 1)) {result in
//            if case let .success(response) = result {
//                let data = try? response.mapJSON()
////                let json = Json(data!)
////                self.dataArray = json["data"].arrayValue
//                print(data)
//
//            }
//            xctest.fulfill()
//
//        }
        SearchImageProvider.request(SearchImage.imageList(keyword: "街拍", page: 1)) { (result) in
            print(result)
        }
        self.waitForExpectations(timeout: 10) { (error) in
            print(error ?? "searchImageApi")
        }
        
        
//        let xctest = self.expectation(description: "searchImageApi")
//        SearchImageProvider.request(SearchImage.imageList(keyword: "街拍", page: 1)) { (result) in
//            do {
//                let response = try result.dematerialize()
//                let jsonStr = try response.mapString()
//                print(jsonStr)
//
//            } catch {
//                let printableError = error as CustomStringConvertible
//                print(printableError.description)
//            }
//
//            xctest.fulfill()
//        }
//        self.waitForExpectations(timeout: 10) { (error) in
//            print(error ?? "searchImageApi")
//        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
