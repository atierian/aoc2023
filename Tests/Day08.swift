import XCTest
@testable import aoc

final class Day08Tests: XCTestCase {
  let testInput = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)

    """
  
  let testInput2 = """
  LLR

  AAA = (BBB, BBB)
  BBB = (AAA, ZZZ)
  ZZZ = (ZZZ, ZZZ)

  """
  
  let part2Input = """
  LR

  11A = (11B, XXX)
  11B = (XXX, 11Z)
  11Z = (11B, XXX)
  22A = (22B, XXX)
  22B = (22C, 22C)
  22C = (22Z, 22Z)
  22Z = (22B, 22B)
  XXX = (XXX, XXX)

  """

  func testPart1() throws {
    let challenge = Day08(input: testInput)
    XCTAssertEqual(challenge.part1(), 2)
    
    let c2 = Day08(input: testInput2)
    XCTAssertEqual(c2.part1(), 6)
  }

  func testPart2() throws {
    let challenge = Day08(input: part2Input)
    XCTAssertEqual(challenge.part2(), 6)
  }
}
