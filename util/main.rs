use std::env;
use std::fs;

fn main() {
    let args = env::args().nth(1).expect("");
    let input = fs::read_to_string(args).expect("");
    println!("{}", input);
}
