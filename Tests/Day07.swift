import XCTest
@testable import aoc

final class Day07Tests: XCTestCase {
  let testInput = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483

    """

  func testPart1() throws {
    let challenge = Day07(input: testInput)
    XCTAssertEqual(challenge.part1(), 6440)
  }

  func testPart2() throws {
    let challenge = Day07(input: testInput)
    XCTAssertEqual(challenge.part2(), 5905)
  }
}
