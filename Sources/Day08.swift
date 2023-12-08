struct Day08: AdventDay {
  var input: String
  
  func part1() -> Int {
    let nodes = nodes
    var instructions = instructions.cycled().makeIterator()
    var current = "AAA", count = 0

    while current != "ZZZ", let next = instructions.next() {
      current = nodes[current]![keyPath: keyPath(for: next)]
      count += 1
    }

    return count
  }

  func part2() -> Int {
    let nodes = nodes
    var currentNodes = nodes.keys.filter { $0.last! == "A" }
    var counts = Array(repeating: 0, count: currentNodes.count)
    var instructions = instructions.cycled().makeIterator()

    for i in currentNodes.indices {
      while currentNodes[i].last! != "Z", let next = instructions.next() {
        currentNodes[i] = nodes[currentNodes[i]]![keyPath: keyPath(for: next)]
        counts[i] += 1
      }
    }

    return counts.reduce(1, lcm)
  }

  func keyPath(for char: Character?) -> KeyPath<Pair<String>, String> {
    switch char {
    case "L": \.left
    case "R": \.right
    default: fatalError()
    }
  }

  // Input mapping
  var nodes: [String: Pair<String>] {
    String(input.split(separator: "\n\n")[1]).lines
      .map {
        let split = $0.components(separatedBy: " = ")
        let key = split[0]
        let values = split[1].dropFirst().dropLast().components(separatedBy: ", ")
        return (key: key, left: values[0], right: values[1])
      }
      .reduce(into: [:]) { dict, node  in
        dict[node.key] = .init(left: node.left, right: node.right)
    }
  }
  
  var instructions: [Character] {
    Array(String(input.split(separator: "\n\n")[0]))
  }

  struct Pair<T> { let left: T, right: T }
}
