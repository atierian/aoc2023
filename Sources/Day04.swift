struct Day04: AdventDay {
  var input: String
  
  private func matches(from input: String) -> [Int] {
    input.lines
      .map { line in
        let lists = line
          .components(separatedBy: [":", "|"])
          .dropFirst()
          .map { Set($0.ints(split: .whitespaces)) }
        return lists[0].intersection(lists[1]).count
      }
  }

  func part1() -> Int {
    let result = matches(from: input)
      .filter { $0 > 0 }
      .reduce(0) { score, matches in
        score + 1 << (matches - 1)
      }
    
    return result
  }

  func part2() -> Int {
    let matches = matches(from: input)

    var cache = [Int: Int]()
    func cardCount(for index: Int) -> Int {
      cache[index] ?? {
        let value = (0..<matches[index]).lazy
          .map { index + 1 + $0 }
          .map(cardCount)
          .reduce(1, +)
        
        cache[index] = value
        return value
      }()
    }

    let result = matches.indices
      .map(cardCount)
      .sum

    return result
  }
}
