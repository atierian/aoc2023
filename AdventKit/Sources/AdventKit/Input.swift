import Foundation

extension StringProtocol {
  public var characters: [Character] {
    Array(self)
  }
  
  public var digits: [Int] {
    compactMap(\.wholeNumberValue)
  }
  
  public var trimmed: String {
    trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  public func ints(split: CharacterSet) -> [Int] {
    components(separatedBy: split).ints
  }
  
  public var int: Int {
    Int(self)!
  }
}

extension String {
  public var lines: [Substring] {
    split(separator: "\n")
  }
}

extension [Character] {
  public var digits: [Int] {
    compactMap(\.wholeNumberValue)
  }
}

extension [String] {
  public var ints: [Int] {
    compactMap(Int.init)
  }
}

extension Character {
  var ascii: Int {
    Int(asciiValue!)
  }
}

extension Collection where Element: Hashable {
  public func histogram() -> [Element: Int] {
    reduce(into: [:]) {
      $0[$1, default: 0] += 1
    }
  }
  
  public func indexedMap() -> [Element: Int] {
    enumerated().reduce(into: [:]) {
      $0[$1.element] = $1.offset
    }
  }
}
