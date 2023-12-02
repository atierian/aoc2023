use std::cmp;

fn main() {
    let test_input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";

    let part_one = part_one(test_input);
    println!("part one: {part_one}");

    let part_two = part_two(test_input);
    println!("part two: {part_two}");
}

fn extract_number(reveal: &str) -> i32 {
    reveal.chars()
        .filter(|c| c.is_numeric())
        .collect::<String>()
        .parse::<i32>()
        .unwrap()
}

fn part_one(input: &str) -> i32 { 
    input.lines().map(|line| { Game::new(line) })
        .filter(|game| game.clone().valid_subsets(12, 13, 14))
        .map(|game| game.id)
        .sum()
}

fn part_two(input: &str) -> i32 { 
    input.lines().map(|line| { Game::new(line) })
        .map(|game| game.required_cubes() )
        .map(|set| set.red * set.green * set.blue)
        .sum()
}

#[derive(Debug, Clone)]
struct Game { 
    id: i32,
    subsets: Vec<RGB>,
}

impl Game { 
    fn new(str: &str) -> Self {
        let game_split: Vec<&str> = str.split(':').collect();
        let game_number: i32 = extract_number(game_split[0]);
        let subsets: Vec<RGB> = game_split[1]
            .split(';')
            .map(|set| { RGB::new(set) })
            .collect();
        Game { 
            id: game_number,
            subsets: subsets,
        }
    }

    fn valid_subsets(self, red: i32, green: i32, blue: i32) -> bool {
        for subset in self.subsets {
            if !subset.is_possible(red, green, blue) {
                return false
            }
        }
        true
    }

    fn required_cubes(self) -> RGB { 
        self.subsets
            .iter()
            .fold(
                RGB { red: 0, green: 0, blue: 0},
                |rgb, set| {
                    RGB { 
                        red: cmp::max(rgb.red, set.red),
                        green: cmp::max(rgb.green, set.green),
                        blue: cmp::max(rgb.blue, set.blue),
                    }
                }
            )
    }
}

#[derive(Debug, Clone)]
struct RGB { 
    red: i32,
    green: i32,
    blue: i32
}

impl RGB {
    fn new(str: &str) -> Self { 
        let mut set = RGB { 
            red: 0,
            green: 0,
            blue: 0
        };
        let reveals: Vec<&str> = str.split(',').collect();
        for reveal in reveals {
            match reveal.to_lowercase() { 
                x if x.contains("red") =>  set.red = extract_number(&x),
                x if x.contains("green") => set.green = extract_number(&x),
                x if x.contains("blue") => set.blue = extract_number(&x),
                default => println!("{}", "unexpected case")
            }
        }
        set
    }

    fn is_possible(self, red: i32, green: i32, blue: i32) -> bool { 
        self.red <= red && self.green <= green && self.blue <= blue
    }
}
