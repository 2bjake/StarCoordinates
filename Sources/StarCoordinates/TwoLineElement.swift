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
  public let inclination: Double
  public let rightAscensionOfTheAscendingNode: Double
  public let eccentricity: Double
  public let argumentOfPerigee: Double
  public let meanAnomaly: Double
  public let meanMotion: Double
  public let revolutions: Int
}

extension TwoLineElement {
  // https://en.wikipedia.org/wiki/Two-line_element_set#Format
  public init?(name: String, lineOne: String, lineTwo: String) {
    self.name = name.trimmingCharacters(in: .whitespaces)

    // line one
    do {
      var lineOne = Substring(lineOne)
      lineOne.removeFirst(2)
      catalogNumber = try makeInt(lineOne.consume(5))
      classification = lineOne.removeFirst()
      lineOne.removeFirst()
      internationalDesignator = InternationalDesignator(launchYear: try makeInt(lineOne.consume(2)),
                                                        launchNumber: try makeInt(lineOne.consume(3)),
                                                        pieceOfLaunch: lineOne.consume(3))
      lineOne.removeFirst()
      epochYear = try makeInt(lineOne.consume(2))
      epochDay = try makeDouble(lineOne.consume(12))
      lineOne.removeFirst()
      firstDerivativeOfMeanMotion = Double(lineOne.consume(10))!
      lineOne.removeFirst()
      secondDerivativeOfMeanMotion = try makeDoubleAssumingDecimal(lineOne.consume(6), exponent: lineOne.consume(2))
      lineOne.removeFirst()
      bstar = try makeDoubleAssumingDecimal(lineOne.consume(6), exponent: lineOne.consume(2))
      lineOne.removeFirst()
      ephemerisType = lineOne.removeFirst()
      lineOne.removeFirst()
      elementSetNumber = Int(lineOne.consume(4))!
    } catch {
      print("failed to parse line one")
      return nil
    }

    // line two
    do {
      var lineTwo = Substring(lineTwo)
      lineTwo.removeFirst(8)
      inclination = try makeDouble(lineTwo.consume(8))
      lineTwo.removeFirst()
      rightAscensionOfTheAscendingNode = try makeDouble(lineTwo.consume(8))
      lineTwo.removeFirst()
      eccentricity = try makeDoubleAssumingDecimal(lineTwo.consume(7))
      lineTwo.removeFirst()
      argumentOfPerigee = try makeDouble(lineTwo.consume(8))
      lineTwo.removeFirst()
      meanAnomaly = try makeDouble(lineTwo.consume(8))
      lineTwo.removeFirst()
      meanMotion = try makeDouble(lineTwo.consume(11))
      revolutions = try makeInt(lineTwo.consume(5))
    } catch {
      print("failed to parse line two")
      return nil
    }
  }
}

private struct ParseError: Error {}

private func makeInt(_ source: String) throws -> Int {
  guard let result = Int(source) else { throw ParseError() }
  return result
}

private func makeDouble(_ source: String) throws -> Double {
  guard let result = Double(source) else { throw ParseError() }
  return result
}

private func makeDoubleAssumingDecimal(_ base: String, exponent: String? = nil) throws -> Double {
  var str = ""
  if base.first == "-" {
    str = "-0." + base.dropFirst()
  } else {
    str = "0." + base
  }

  if let exponent = exponent {
    str += "e" + exponent
  }

  return try makeDouble(str)
}

private extension Substring {
  // Given that this trims strings, it's not generally useful.
  mutating func consume(_ k: Int) -> String {
    let result = String(self.prefix(k).trimmingCharacters(in: .whitespaces))
    self.removeFirst(k)
    return result
  }
}
