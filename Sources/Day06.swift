struct Day06: AdventDay {
  var input: String

  func part1() -> Int {
    let lines = input.lines
      .map { $0.split(separator: " ").compactMap(Double.init) }

    return zip(lines[0], lines[1]).map(quadraticish).product
  }

  func part2() -> Int {
    let lines = input.lines
      .map { Double(String($0.filter(\.isNumber)))! }

    return quadraticish(a: lines[0], b: lines[1])
  }

  private func quadraticish(a: Double, b: Double) -> Int {
    let root = (a * a - 4 * b).squareRoot()
    let x = [-root, root].map { ($0 - a) / 2 }
    return Int(ceil(x[1] - 1) - floor(x[0] + 1)) + 1
  }
}
