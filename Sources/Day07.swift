struct Day07: AdventDay {
  var input: String

  func part1() -> Int {
    winnings(
      from: input.lines.map(Hand.wild(.none)),
      rank: "AKQJT98765432"
    )
  }

  func part2() -> Int {
    winnings(
      from: input.lines.map(Hand.wild(.joker)),
      rank: "AKQT98765432J"
    )
  }

  private func winnings(from hands: [Hand], rank: String) -> Int {
    hands
      .sorted(by: { a, b in
        let aRank = a.rank, bRank = b.rank
        if aRank == bRank {
          let firstDistinct = zip(a.cards, b.cards).first { $0.0 != $0.1 }!
          let indexedRanks = rank.indexedMap()
          return indexedRanks[firstDistinct.0]! > indexedRanks[firstDistinct.1]!
        }
        return aRank > bRank
      })
      .enumerated()
      .reduce(0) { $0 + $1.element.bid * ($1.offset + 1)}
  }
}

struct Hand {
  let cards: String
  let bid: Int
  let wild: Wildcard

  static func wild(_ wildcard: Wildcard) -> ((String.SubSequence) -> Self) {
    {
      let hand = $0.components(separatedBy: .whitespaces)
      return Hand(cards: hand[0], bid: hand[1].int, wild: wildcard)
    }
  }

  var rank: Int {
    Self.handStrength.firstIndex {
      $0(wild.map(cards.histogram()))
    }!
  }

  static let handStrength: [([Character: Int]) -> Bool] = [
    { $0.keys.count == 1 }, // Five of a kind
    { $0.values.sorted() == [1, 4] }, // Four of a kind
    { $0.values.sorted() == [2, 3] }, // Full house
    { $0.values.sorted().suffix(1) == [3] }, // Three of a kind
    { $0.values.sorted().suffix(2) == [2, 2] }, // Two pair
    { $0.values.sorted().last! == 2 }, // One pair
    { _ in true }, // High card
  ]
}

struct Wildcard {
  let map: ([Character: Int]) -> [Character: Int]
  static let none = Self { $0 }
  static let joker = Self { histogram in
    var histogram = histogram
    if let wild = histogram["J"], wild != 5 {
      histogram.removeValue(forKey: "J")
      let maxValue = histogram.values.max()
      let bestCard = histogram.keys
        .filter { histogram[$0] == maxValue }
        .max { a, b in
          let indexedRanks = "AKQT98765432J".indexedMap()
          return indexedRanks[a]! > indexedRanks[b]!
        }!
      histogram[bestCard]! += wild
    }
    return histogram
  }
}
