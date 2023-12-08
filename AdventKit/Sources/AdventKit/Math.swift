extension Collection where Element: AdditiveArithmetic {
  public var sum: Element {
    reduce(.zero, +)
  }
}

extension Collection where Element: BinaryInteger {
  public var product: Element {
    reduce(1, *)
  }
}

extension BinaryInteger {
  public var isZero: Bool { self == 0 }
  public var isNonZero: Bool { !isZero }
}

public func gcd(_ x: Int, _ y: Int) -> Int {
  var a = 0
  var b = max(x, y)
  var r = min(x, y)
  while r != 0 {
    a = b
    b = r
    r = a % b
  }

  return b
}

public func lcm(_ x: Int, _ y: Int) -> Int {
  x / gcd(x, y) * y
}
