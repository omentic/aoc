use std::env;
use std::fs;

fn main() {
    let args = env::args().nth(1).unwrap();
    let input = fs::read_to_string(args).unwrap().trim().split("\n\n")
        .map(|x| x.trim().split("\n").map(|x| x.parse::<i32>().unwrap())
            .collect()).collect::<Vec<Vec<i32>>>();
    // println!("{:?}", input);

    let mut elves = input.iter().map(|x| x.iter().fold(0, |x,y| x + y))
        .collect::<Vec<i32>>();
    println!("{}", elves.iter().fold(0, |x,y| x.max(*y)));

    elves.sort_by(|x,y| y.cmp(x));
    println!("{}", elves[0] + elves[1] + elves[2]);
}
