struct Day08: AdventDay {
  var input: String
  
  func part1() -> Int {
    var current = "AAA"
    let instructionCount = instructions.count
    var count = 0, instructionIndex = 0
    while current != "ZZZ" {
      let instruction = instructions[instructionIndex]
      switch instruction {
      case "L": current = nodes[current]!.0
      case "R": current = nodes[current]!.1
      default: fatalError()
      }
      count += 1
      instructionIndex += 1
      instructionIndex %= instructionCount
    }
    
    return count
  }

  func part2() -> Int {
    var currentNodes = nodes.keys.filter { $0.last! == "A" }.map { String($0) }
    let instructionCount = instructions.count
    var counts = Array(repeating: 0, count: currentNodes.count), instructionIndex = 0
    
    for i in currentNodes.indices {
      while currentNodes[i].last! != "Z" {
        let instruction = instructions[instructionIndex]
        switch instruction {
        case "L": currentNodes[i] = nodes[currentNodes[i]]!.0
        case "R": currentNodes[i] = nodes[currentNodes[i]]!.1
        default: fatalError()
        }
        counts[i] += 1
        instructionIndex += 1
        instructionIndex %= instructionCount
      }
      instructionIndex = 0
    }

    return counts.reduce(1, lcm)
  }
  
  var nodes: [String: (String, String)] {
    String(input.split(separator: "\n\n")[1]).lines
      .map {
        let split = $0.components(separatedBy: " = ")
        let key = split[0]
        let values = split[1].dropFirst().dropLast().components(separatedBy: ", ")
        return (key: key, left: values[0], right: values[1])
      }
      .reduce(into: [String: (String, String)]()) { dict, node  in
        dict[node.key] = (node.left, node.right)
    }
  }
  
  var instructions: [Character] {
    Array(String(input.split(separator: "\n\n")[0]))
  }
}

func gcd(_ x: Int, _ y: Int) -> Int {
    var a = 0
    var b = max(x, y)
    var r = min(x, y)
    
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

func lcm(_ x: Int, _ y: Int) -> Int {
    x / gcd(x, y) * y
}
