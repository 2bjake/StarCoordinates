//
//  SGP4Tests.swift
//  
//
//  Created by Jake Foster on 1/30/22.
//

import XCTest
import StarCoordinates
import WrappedSGP4

class SGP4Tests: XCTestCase {
    func testExample() throws {
      let tle = try XCTUnwrap(TwoLineElement(name: "ISS",
                                             lineOne: "1 25544U 98067A   22030.51179398  .00005765  00000+0  11002-3 0  9999",
                                             lineTwo: "2 25544  51.6444 298.3935 0006761  77.9892 281.4353 15.49702707323823"))

      let altAz = computeAltAz(Angle(dms: .init(degrees: 30, minutes: 22, seconds: 38)).decimalDegrees,
                               Angle(dms: .init(degrees: -97, minutes: 50, seconds: 56)).decimalDegrees,
                               tle.lineOne,
                               tle.lineTwo)

      let coords = HorizontalCoordinates(altitude: .init(radians: altAz.alt), azimuth: .init(radians: altAz.az))
      print("azimuth", coords.azimuth.dms, "altitude", coords.altitude.dms)
    }
}
