

public struct TwoLineElement {
  public struct InternationalDesignator {
    public let launchYear: Int
    public let launchNumber: Int
    public let pieceOfLaunch: String
  }

  public let name: String

  // line 1
  public let catalogNumber: Int
  public let classification: Character
  public let internationalDesignator: InternationalDesignator
  public let epochYear: Int
  public let epochDay: Double
  public let firstDerivativeOfMeanMotion: Double
  public let secondDerivativeOfMeanMotion: Double
  public let bstar: Double
  public let ephemerisType: Character
  public let elementSetNumber: Int

  // line 2
//  let inclination: Double
//  let rightAscensionOfTheAscendingNode: Double
//  let eccentricity: Double
//  let argumentOfPerigee: Double
//  let meanAnomaly: Double
//  let meanMotion: Double
//  let revolutions: Int
}

extension TwoLineElement {
  public init(name: String, lineOne: String, lineTwo: String) {
    self.name = name

    var lineOne = Substring(lineOne)
    lineOne.removeFirst(2)
    catalogNumber = Int(lineOne.consume(5))!
    classification = lineOne.removeFirst()
    lineOne.removeFirst()
    internationalDesignator = InternationalDesignator(
      launchYear: Int(lineOne.consume(2))!,
      launchNumber: Int(lineOne.consume(3))!,
      pieceOfLaunch: lineOne.consume(3))
    lineOne.removeFirst()
    epochYear = Int(lineOne.consume(2))!
    epochDay = Double(lineOne.consume(12))!
    lineOne.removeFirst()
    firstDerivativeOfMeanMotion = Double(lineOne.consume(10))!
    lineOne.removeFirst()
    secondDerivativeOfMeanMotion = assumeDecimalDouble(lineOne.consume(6), exponent: lineOne.consume(2))
    lineOne.removeFirst()
    bstar = assumeDecimalDouble(lineOne.consume(6), exponent: lineOne.consume(2))
    lineOne.removeFirst()
    ephemerisType = lineOne.removeFirst()
    lineOne.removeFirst()
    elementSetNumber = Int(lineOne.consume(4))!
  }
}

func assumeDecimalDouble(_ base: String, exponent: String? = nil) -> Double {
  var str = ""
  if base.first == "-" {
    str = "-0." + base.dropFirst()
  } else {
    str = "0." + base
  }

  if let exponent = exponent {
    str += "e" + exponent
  }

  return Double(str)!
}

private extension Substring {
  // Given that this trims strings, it's not generally useful.
  mutating func consume(_ k: Int) -> String {
    let result = String(self.prefix(k).trimmingCharacters(in: .whitespaces))
    self.removeFirst(k)
    return result
  }
}
