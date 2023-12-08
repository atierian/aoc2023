struct Day05: AdventDay {
  var input: String
  
  func part1() -> Int {
    let splits = input.split(separator: "\n\n")
    let seeds = splits[0].split(separator: ": ")[1].ints(split: .whitespaces)
    let stages = stages(from: splits)

    var closestLocation = Int.max
    for seed in seeds {
      var location = seed
      for mapping in stages {
        location = mapping
          .first(where: { $0.source.contains(location) })
          .map {
            $0.destination.lowerBound - $0.source.lowerBound + location
          } ?? location
      }
      closestLocation = min(closestLocation, location)
    }
    return closestLocation
  }

  func part2() -> Int {
    let sections = input.split(separator: "\n\n")
    let stages = stages(from: sections)

    var source = sections[0].split(separator: ": ")[1]
      .ints(split: .whitespaces)
      .chunks(ofCount: 2)
      .map(Array.init)
      .compactMap { chunk in
        chunk[0]..<(chunk[0] + chunk[1])
      }
      .reduce(into: IndexSet()) { indexSet, range in
        indexSet.insert(integersIn: range)
      }

    for stage in stages {
      var destination = IndexSet()
      for map in stage {
        let sourceRanges = IndexSet(integersIn: map.source).intersection(source).rangeView
        for sourceRange in sourceRanges {
          destination.insert(integersIn: map.destination(basedOn: sourceRange))
          source.remove(integersIn: sourceRange)
        }
      }
      source.formUnion(destination)
    }

    return source.rangeView.map(\.lowerBound).min()!
  }

  struct Mapping {
    let source: Range<Int>
    let destination: Range<Int>

    init(_ map: [Int]) {
      source = map[1]..<(map[1] + map[2])
      destination = map[0]..<(map[0] + map[2])
    }

    func destination(basedOn sourceRange: Range<Int>) -> Range<Int> {
      let offset = source.lowerBound - destination.lowerBound
      return (sourceRange.lowerBound - offset)..<(sourceRange.upperBound - offset)
    }
  }
  
  private func stages(from input: [String.SubSequence]) -> [[Mapping]] {
    input.dropFirst().map {
      $0.split(separator: "\n")
        .dropFirst()
        .map { $0.ints(split: .whitespaces) }
        .map(Mapping.init)
    }
  }
}
