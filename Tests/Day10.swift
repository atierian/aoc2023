import XCTest
@testable import aoc

final class Day10Tests: XCTestCase {
  let testInput = """

    """

  func testPart1() throws {
    let challenge = Day10(input: testInput)
    XCTAssertEqual(challenge.part1(), 42)
  }

  func testPart2() throws {
    let challenge = Day10(input: testInput)
    XCTAssertEqual(challenge.part2(), 42)
  }
}
