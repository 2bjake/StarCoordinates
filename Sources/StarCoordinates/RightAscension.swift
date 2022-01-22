import Foundation

public struct RightAscension {
  public let hours: Int
  public let minutes: Int
  public let seconds: Double
  public let decimalDegrees: Double

  public init(hours: Int, minutes: Int, seconds: Double = 0) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = seconds
    self.decimalDegrees = 15 * (Double(hours) + Double(minutes) / 60 + seconds / 3600)
  }
}

extension RightAscension {
  public func hourAngle(longitude: Angle, date: Date) -> Angle {
    let lst = date.localSiderealTime(longitude: longitude)
    return Angle(decimalDegrees: lst.decimalDegrees - self.decimalDegrees).wrappedTo360()
  }
}
