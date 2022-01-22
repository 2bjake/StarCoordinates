public struct EquatorialCoordinates {
  public let epoch: Epoch = .j2000

  public var rightAscension: RightAscension
  public var declination: Angle

  public init(rightAscension: RightAscension, declination: Angle) {
    self.rightAscension = rightAscension
    self.declination = declination
  }
}
