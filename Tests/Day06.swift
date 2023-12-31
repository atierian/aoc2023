import XCTest
@testable import aoc

final class Day06Tests: XCTestCase {
  let testInput = """
    Time:      7  15   30
    Distance:  9  40  200

    """

  func testPart1() throws {
    let challenge = Day06(input: testInput)
    XCTAssertEqual(challenge.part1(), 288)
  }

  func testPart2() throws {
    let challenge = Day06(input: testInput)
    XCTAssertEqual(challenge.part2(), 71503)
  }
}
