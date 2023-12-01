import kotlin.math.min

fun main(args: Array<String>) {
    val input = ""
    val lines = input.trimIndent().lines()

    // Part One
    val partOne = lines
        .map { line ->
            val digits = line.mapNotNull {
                it.digitToIntOrNull()
            }
            return@map digits.first() * 10 + digits.last()
        }
        .sum()

    println("partOne: $partOne")

    // Part Two
    fun firstNumber(line: String, wordMap: Map<String, Int>): Int {
        for (i in line.indices) {
            val digit = line[i].digitToIntOrNull()
            if (digit != null) {
                return digit
            }
            val wordDigit = wordMap.keys
                .asSequence()
                .map { min(i + it.length, line.length) }
                .distinct()
                .sorted()
                .map { endIndex ->
                    line.substring(
                        startIndex = i,
                        endIndex = endIndex
                    )
                }
                .find { wordMap[it] != null }
                ?.let { wordMap[it] }

            if (wordDigit != null) {
                return wordDigit
            }
        }
        return null!!
    }

    val lookup = mapOf(
        "one" to 1,
        "two" to 2,
        "three" to 3,
        "four" to 4,
        "five" to 5,
        "six" to 6,
        "seven" to 7,
        "eight" to 8,
        "nine" to 9
    )

    val reversedLookup = lookup.mapKeys { it.key.reversed() }

    val partTwo = lines
        .map { line ->
            val first = firstNumber(line, lookup)
            val last = firstNumber(line.reversed(), reversedLookup)
            return@map first * 10 + last
        }
        .sum()

    println("partTwo: $partTwo")
}