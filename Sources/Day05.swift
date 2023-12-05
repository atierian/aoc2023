struct Day05: AdventDay {
  var input: String
  
  func part1() -> Int {
    let splits = input.split(separator: "\n\n")
    let seeds = splits[0].split(separator: ": ")[1].ints(split: .whitespaces)
    let stages = stages(from: splits)
    return closestLocation(seeds: seeds, stages: stages)
  }

  func part2() -> Int {
    let splits = input.split(separator: "\n\n")
    let seeds = splits[0].split(separator: ": ")[1].ints(split: .whitespaces)
      .chunks(ofCount: 2)
      .map(Array.init)
      .flatMap { chunk in
        Array(chunk[0]...(chunk[0] + chunk[1] - 1))
      }
    
    let stages = stages(from: splits)
    return closestLocation(seeds: seeds, stages: stages)
  }
  
  struct Stage {
    let sourceRange: ClosedRange<Int>
    let destinationRange: ClosedRange<Int>
  }
  
  private func stagesForSection(_ section: String.SubSequence) -> [Stage] {
    section.split(separator: "\n")
      .dropFirst()
      .map { $0.ints(split: .whitespaces) }
      .map { line in
        Stage(
          sourceRange: line[1]...(line[1] + line[2] - 1),
          destinationRange: line[0]...(line[0] + line[2] - 1)
        )
    }
  }

  private func destination(from source: Int, stages: [Stage]) -> Int {
    stages
      .first(where: { $0.sourceRange.contains(source) })
      .map {
        $0.destinationRange.lowerBound - $0.sourceRange.lowerBound + source
      } ?? source
  }
  
  private func stages(from input: [String.SubSequence]) -> [[Stage]] {
    input.dropFirst().map(stagesForSection(_:))
  }
  
  private func closestLocation(seeds: [Int], stages: [[Stage]]) -> Int {
    var closestLocation = Int.max
    for seed in seeds {
      var location = seed
      for stage in stages {
        location = destination(from: location, stages: stage)
      }
      closestLocation = min(closestLocation, location)
    }
    return closestLocation
  }
}
