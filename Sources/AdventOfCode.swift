import ArgumentParser
import Foundation

// Add each new day implementation to this array:
let allChallenges: [any AdventDay] = [
	Day03(),
	Day04(),
  Day05()
]

@main
struct AdventOfCode: AsyncParsableCommand {
  @Argument(help: "The day of the challenge. For December 1st, use '1'.")
  var day: Int?

  @Flag(help: "Benchmark the time taken by the solution")
  var benchmark: Bool = false

  /// The selected day, or the latest day if no selection is provided.
  var selectedChallenge: any AdventDay {
    get throws {
      if let day {
        if let challenge = allChallenges.first(where: { $0.day == day }) {
          return challenge
        } else {
          throw ValidationError("No solution found for day \(day)")
        }
      } else {
        return latestChallenge
      }
    }
  }

  /// The latest challenge in `allChallenges`.
  var latestChallenge: any AdventDay {
    allChallenges.max(by: { $0.day < $1.day })!
  }

  func run(part: () async throws -> Any, named: String) async -> Duration {
    var result: Result<Any, Error> = .success("<unsolved>")
    let timing = await ContinuousClock().measure {
      do {
        result = .success(try await part())
      } catch {
        result = .failure(error)
      }
    }
    switch result {
    case .success(let success):
      print("\(named): \(success)")
    case .failure(let failure):
      print("\(named): Failed with error: \(failure)")
    }
    return timing
  }

  func run() async throws {
    let challenge = try selectedChallenge
    print("Executing Advent of Code challenge \(challenge.day)...")

    let timePart1 = await run(part: challenge.part1, named: "Part 1")
    let timePart2 = await run(part: challenge.part2, named: "Part 2")

    if benchmark {
      print("Part 1 took \(time: timePart1), part 2 took \(time: timePart2).")
      #if DEBUG
        print("Looks like you're benchmarking debug code. Try swift run -c release")
      #endif
    }
  }
}

let timeFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.maximumFractionDigits = 3
    return f
}()

extension String.StringInterpolation {
  mutating func appendInterpolation(time: Duration) {
    var time = Double(time.components.seconds) + (Double(time.components.attoseconds) / 1.0e18)

    let unit: String
    if time > 1.0 {
      unit = "s"
    } else if time > 0.001 {
      unit = "ms"
      time *= 1_000
    } else if time > 0.000_001 {
      unit = "µs"
      time *= 1_000_000
    } else {
      unit = "ns"
      time *= 1_000_000_000
    }
    let string = timeFormatter.string(
      from: NSNumber(value: time)
    )! + unit
    
    appendLiteral(string)
  }
}
