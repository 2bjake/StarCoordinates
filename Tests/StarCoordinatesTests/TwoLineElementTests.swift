//
//  TwoLineElementTests.swift
//  
//
//  Created by Jake Foster on 1/30/22.
//

import XCTest
import StarCoordinates

class TwoLineElementTests: XCTestCase {
    func testExample() throws {

      let name = "ISS (ZARYA)"
      let lineOne = "1 25544U 98067A   08264.51782528 -.00002182  00000-0 -11606-4 0  2927"
      let lineTwo = "2 25544  51.6416 247.4627 0006703 130.5360 325.0288 15.72125391563537"
      let tle = TwoLineElement(name: name, lineOne: lineOne, lineTwo: lineTwo)
      print(tle)
    }
}
