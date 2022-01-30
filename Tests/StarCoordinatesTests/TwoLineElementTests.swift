//
//  TwoLineElementTests.swift
//  
//
//  Created by Jake Foster on 1/30/22.
//

import XCTest
@testable import StarCoordinates


private func XCTAssertEqual(_ a: TwoLineElement, _ b: TwoLineElement, _ keyPath: KeyPath<TwoLineElement, Double>) {
  XCTAssertEqual(a[keyPath: keyPath], b[keyPath: keyPath], accuracy: 0.01)
}

private func XCTAssertEqual<T: Equatable>(_ a: TwoLineElement, _ b: TwoLineElement, _ keyPath: KeyPath<TwoLineElement, T>) {
  XCTAssertEqual(a[keyPath: keyPath], b[keyPath: keyPath])
}

class TwoLineElementTests: XCTestCase {
    func testExample() throws {

      let name = "ISS (ZARYA)    "
      let lineOne = "1 25544U 98067A   08264.51782528 -.00002182  00000-0 -11606-4 0  2927"
      let lineTwo = "2 25544  51.6416 247.4627 0006703 130.5360 325.0288 15.72125391563537"
      let tle = try XCTUnwrap(TwoLineElement(name: name, lineOne: lineOne, lineTwo: lineTwo))
      let expected = TwoLineElement(name: "ISS (ZARYA)", catalogNumber: 25544, classification: "U", internationalDesignator: .init(launchYear: 98, launchNumber: 67, pieceOfLaunch: "A"), epochYear: 08, epochDay: 264.51782528, firstDerivativeOfMeanMotion: -0.00002182, secondDerivativeOfMeanMotion: 0, bstar: -0.11606E-4, ephemerisType: "0", elementSetNumber: 292, inclination: 51.6416, rightAscensionOfTheAscendingNode: 247.4627, eccentricity: 0.0006703, argumentOfPerigee: 130.5360, meanAnomaly: 325.0288, meanMotion: 15.72125391, revolutions: 56353)

      XCTAssertEqual(tle, expected, \.name)
      XCTAssertEqual(tle, expected, \.catalogNumber)
      XCTAssertEqual(tle, expected, \.classification)
      XCTAssertEqual(tle, expected, \.internationalDesignator.launchYear)
      XCTAssertEqual(tle, expected, \.internationalDesignator.launchNumber)
      XCTAssertEqual(tle, expected, \.internationalDesignator.pieceOfLaunch)
      XCTAssertEqual(tle, expected, \.epochYear)
      XCTAssertEqual(tle, expected, \.epochDay)
      XCTAssertEqual(tle, expected, \.firstDerivativeOfMeanMotion)
      XCTAssertEqual(tle, expected, \.secondDerivativeOfMeanMotion)
      XCTAssertEqual(tle, expected, \.bstar)
      XCTAssertEqual(tle, expected, \.ephemerisType)
      XCTAssertEqual(tle, expected, \.elementSetNumber)
      XCTAssertEqual(tle, expected, \.inclination)
      XCTAssertEqual(tle, expected, \.rightAscensionOfTheAscendingNode)
      XCTAssertEqual(tle, expected, \.eccentricity)
      XCTAssertEqual(tle, expected, \.argumentOfPerigee)
      XCTAssertEqual(tle, expected, \.meanAnomaly)
      XCTAssertEqual(tle, expected, \.meanMotion)
      XCTAssertEqual(tle, expected, \.revolutions)
    }
}
