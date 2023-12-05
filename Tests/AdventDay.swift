import XCTest
@testable import AdventOfCode

class AdventDayTestCase: XCTestCase {}

extension XCTestCase {
  func XCTAssertChallengePart<T: Equatable>(
    _ part: () async throws -> T,
    _ value: T
  ) async {
    do {
      let part = try await part()
      XCTAssertEqual(part, value)
    } catch {
      XCTFail("Expected: \(value) | received error: \(error)")
    }
  }
  
  func XCTAssertChallengePart<T: Equatable>(
    _ part: () throws -> T,
    _ value: T
  ) rethrows {
      XCTAssertEqual(try part(), value)
  }
}
