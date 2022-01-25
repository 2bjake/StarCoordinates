import Foundation

public struct Angle {
  public struct DMS {
    public let degrees: Int
    public let minutes: Int
    public let seconds: Double
  }

  public let dms: DMS
  public let decimalDegrees: Double
  public let radians: Double

  public init(dms: DMS) {
    self.dms = dms
    self.decimalDegrees = dms.toDecimalDegrees()
    self.radians = decimalDegrees.toRadians()
  }

  public init(degrees: Int, minutes: Int, seconds: Double = 0) {
    self.init(dms: DMS(degrees: degrees, minutes: minutes, seconds: seconds))
  }

  public init(decimalDegrees: Double) {
    self.decimalDegrees = decimalDegrees
    self.radians = decimalDegrees.toRadians()
    self.dms = decimalDegrees.toDMS()
  }

  public init(radians: Double) {
    self.radians = radians
    self.decimalDegrees = radians.toDegrees()
    self.dms = decimalDegrees.toDMS()
  }

  // TODO: operators?

  public mutating func wrapTo360() {
    var degrees = fmod(self.decimalDegrees, 360)
    if degrees < 0 { degrees += 360 }
    self = .init(decimalDegrees: degrees)
  }

  // decimalDegrees >= 0 and < 360
  public func wrappedTo360() -> Angle {
    var angle = self
    angle.wrapTo360()
    return angle
  }

  // decimalDegrees > -180 and <= 180
  public func wrappedTo180() -> Angle {
    var wrapped = wrappedTo360().decimalDegrees
    if wrapped > 180 { wrapped -= 360 }
    return Angle(decimalDegrees: wrapped)
  }
}

fileprivate extension Double {
  func toRadians() -> Double {
    self * .pi / 180
  }

  func toDegrees() -> Double {
    self * 180 / .pi
  }

  func toDMS() -> Angle.DMS {
    let degrees = Int(self)
    let remainder = abs(self) - Double(abs(degrees))
    let minutes = Int(remainder * 60)
    let seconds = (remainder - Double(minutes) / 60) * 3600
    return .init(degrees: degrees, minutes: minutes, seconds: seconds)
  }
}

extension Angle.DMS {
  func toDecimalDegrees() -> Double {
    var minutes = Double(minutes)
    var seconds = seconds
    if degrees < 0 {
      minutes *= -1
      seconds *= -1
    }
    return Double(degrees) + minutes / 60 + seconds / 3600
  }
}
