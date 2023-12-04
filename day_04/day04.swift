import Algorithms
import Foundation

struct Day04: AdventDay {
  var data: String
  
  private func matches(from input: String) -> [Int] {
    input.split(separator: "\n")
      .map { line in
        let lists = line
          .components(separatedBy: [":", "|"])
          .dropFirst()
          .map {
            Set(
              $0
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            )
          }
        return lists[0].intersection(lists[1]).count
      }
  }

  func part1() -> String {
    let result = matches(from: data)
      .filter { $0 > 0 }
      .reduce(0) { score, matches in
        score + 1 << (matches - 1)
      }
    
    return String(result)
  }

  func part2() -> String {
    let matches = matches(from: data)
    var cache = [Int: Int]()
    func cardCount(for index: Int) -> Int {
      cache[index] ?? {
        let value = (0..<matches[index])
          .lazy
          .map { cardCount(for: index + 1 + $0) }
          .reduce(1, +)
        cache[index] = value
        return value
      }()
    }
    
    let result = matches.indices
      .map { cardCount(for: $0) }
      .reduce(0, +)
    
    return String(result)
  }
}
