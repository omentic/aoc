use std::env;
use std::fs;

fn main() {
    let args = env::args().nth(1).unwrap();
    let mut input = fs::read_to_string(args).unwrap().trim().split("\n\n").map(|x| x.trim().split("\n")
        .map(|x| x.parse::<i32>().unwrap()).collect()).collect::<Vec<Vec<i32>>>().iter()
        .map(|x| x.iter().fold(0, |x,y| x + y)).collect::<Vec<i32>>();
    // println!("{:?}", input);
    println!("{}", input.iter().fold(0, |x,y| x.max(*y)));

    input.sort_by(|x,y| y.cmp(x));
    println!("{}", input[0] + input[1] + input[2]);
}
