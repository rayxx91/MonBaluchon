//
//  WeatherServiceTestCase.swift
//  MonBaluchonTests
//
//  Created by chaleroux on 20/01/2022.
//

import XCTest
@testable import MonBaluchon

class WeatherServiceTestCase: XCTestCase {

    class WeatherTests: XCTestCase {
        func testinitWeather() {
            let weather = Weather(id: 200, main: "Montpellier", description: "Blue sky", icon: "sun.png")
            
            XCTAssertEqual(200, weather.id)
            XCTAssertEqual("Montpellier", weather.main)
            XCTAssertEqual("Blue sky", weather.description)
            XCTAssertEqual("sun.png", weather.icon)

        }
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
