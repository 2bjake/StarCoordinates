import Foundation
import WrappedSGP4

public struct HorizontalCoordinates {
  public var altitude: Angle
  public var azimuth: Angle

  public init(altitude: Angle, azimuth: Angle) {
    self.altitude = altitude
    self.azimuth = azimuth
  }
}

extension HorizontalCoordinates {
  public init(coordinates: EquatorialCoordinates, location: Location, date: Date) {
    let hourAngle = coordinates.rightAscension.hourAngle(longitude: location.longitude, date: date)

    let haRad = hourAngle.radians
    let decRad = coordinates.declination.radians
    let latRad = location.latitude.radians

    let altRad = asin(sin(decRad) * sin(latRad) + cos(decRad) * cos(latRad) * cos(haRad))

    let aRad = acos((sin(decRad) - sin(altRad) * sin(latRad)) / (cos(altRad) * cos(latRad)))

    var azRad: Double
    if sin(haRad) < 0 {
      azRad = aRad
    } else {
      azRad = (2 * .pi) - aRad
    }

    self.altitude = Angle(radians: altRad)
    self.azimuth = Angle(radians: azRad)
  }

  public init(tle: TwoLineElement, location: Location, date: Date) {
    let altAz = computeAltAz(location.latitude.decimalDegrees, location.longitude.decimalDegrees, tle.lineOne, tle.lineTwo, date)
    self.altitude = Angle(radians: altAz.alt)
    self.azimuth = Angle(radians: altAz.az)
  }
}
