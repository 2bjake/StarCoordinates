import XCTest
import CoreLocation
import StarCoordinates

private func validate(_ instruction: AzimuthInstruction, _ heading: CardinalDirection, _ shouldRotateClockwise: Bool, _ adjustedAngle: Double) {
  XCTAssertEqual(instruction.heading, heading)
  XCTAssertEqual(instruction.shouldRotateClockwise, shouldRotateClockwise)
  XCTAssertEqual(instruction.adjustedAngle, adjustedAngle)
}

final class StarCoordinatesTests: XCTestCase {
    func testAzimuthInstruction() throws {
      validate(AzimuthInstruction(angle: 45), .east, false, 45)
      validate(AzimuthInstruction(angle: 0), .north, true, 0)
      validate(AzimuthInstruction(angle: 215), .south, true, 215 - 180)
      validate(AzimuthInstruction(angle: 359), .north, false, 1)
      validate(AzimuthInstruction(angle: 271), .west, true, 1)
      validate(AzimuthInstruction(angle: 5), .north, true, 5)
    }

  @available(macOS 12.0, *)
  func m13Example() throws {
    // http://www.stargazing.net/kepler/altaz.html
    let m13Coordinates = EquatorialCoordinates(rightAscension: .init(hours: 16, minutes: 41, seconds: 42),
                                               declination: .init(degrees: 36, minutes: 28, seconds: 0))

    let birminghamUKLoc = CLLocationCoordinate2D(latitude: 52.5, longitude: -1.9166667)
    let exampleDate = try! Date("1998-08-10T23:10:00Z", strategy: .iso8601)

    XCTAssertEqual(exampleDate.daysSince(epoch: .j2000), -508.53472, accuracy: 0.01)

    let lst = exampleDate.localSiderealTime(longitude: birminghamUKLoc.longitude)
    XCTAssertEqual(lst.decimalDegrees, 304.80762, accuracy: 0.01)

    let hourAngle = m13Coordinates.rightAscension.hourAngle(longitude: birminghamUKLoc.longitude, date: exampleDate)
    XCTAssertEqual(hourAngle.decimalDegrees, 54.382617, accuracy: 0.01)

    let horizontalCoordinates = HorizontalCoordinates(coordinates: m13Coordinates, location: birminghamUKLoc, date: exampleDate)
    XCTAssertEqual(horizontalCoordinates.altitude.decimalDegrees, 49.169122, accuracy: 0.01)
    XCTAssertEqual(horizontalCoordinates.azimuth.decimalDegrees, 269.14634, accuracy: 0.01)
  }

  @available(macOS 12.0, *)
  func haleBoppExample() throws {
    // http://www.stargazing.net/kepler/altaz.html
    let date = try! Date("1997-03-14T19:00:00Z", strategy: .iso8601)
    let birminghamUKLoc = CLLocationCoordinate2D(latitude: 52.5, longitude: -1.9166667)
    let cometCoordinates = EquatorialCoordinates(rightAscension: .init(hours: 22, minutes: 59, seconds: 48), declination: .init(degrees: 42, minutes: 43, seconds: 0))

    let lst = date.localSiderealTime(longitude: birminghamUKLoc.longitude)
    XCTAssertEqual(lst.decimalDegrees / 15, 6.367592, accuracy: 0.01)

    let horizontalCoordinates = HorizontalCoordinates(coordinates: cometCoordinates, location: birminghamUKLoc, date: date)
    XCTAssertEqual(horizontalCoordinates.altitude.decimalDegrees, 22.40100, accuracy: 0.01)
    XCTAssertEqual(horizontalCoordinates.azimuth.decimalDegrees, 311.92258, accuracy: 0.01)
  }
}