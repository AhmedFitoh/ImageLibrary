//
//  AdsInjectorTest.swift
//  ImageLibraryTests
//
//  Created by AhmedFitoh on 10/10/21.
//

import XCTest
@testable import ImageLibrary

class AdsInjectorTest: XCTestCase {
    
    private var testList: ImageList = []
    
    override func setUp() {
        super.setUp()
        fillTestList()
        
    }
    
    private func fillTestList(){        
        WebServiceMock().request(value: ImageList.self,
                                 from: Endpoints.fetchImageList) {[weak self] result in
            switch result {
            case .success(let list):
                self?.testList = list
            case .failure(let error):
                print (error)
            }
        }
    }
    
    func testEmptyInput(){
        let injector = AdsInjector()
        
        let result = injector.injectAdsIn([])
        
        XCTAssertEqual(result.isEmpty, true, "List should be empty")
    }
    
    func testFourItemsInput() throws {
        let list = [testList [0], testList [1], testList [2], testList [3]]
        
        let injector = AdsInjector()
        let result = injector.injectAdsIn(list)
        
        XCTAssertEqual(result.count, 4, "List should be four items")
    }
    
    func testTenItemsInput() throws {
        let injector = AdsInjector()
        let result = injector.injectAdsIn(testList)
        
        XCTAssertEqual(result.count, 12, "List should be twelve items")
        
        switch result [5] {
        case .adCell:
            break
        default:
            XCTFail("Item should be an Ad")
        }
        
        switch result [11] {
        case .adCell:
            break
        default:
            XCTFail("Item should be an Ad")
        }
    }
}
