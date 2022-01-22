import CoreLocation

public struct Location {
  public var latitude: Angle
  public var longitude: Angle

  public init(latitude: Angle, longitude: Angle) {
    self.latitude = latitude
    self.longitude = longitude
  }

  public init(latitude: Double, longitude: Double) {
    self.init(latitude: .init(decimalDegrees: latitude), longitude: .init(decimalDegrees: longitude))
  }

  public init(location: CLLocationCoordinate2D) {
    self.init(latitude: location.latitude, longitude: location.longitude)
  }
}
