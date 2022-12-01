use std::env;
use std::fs;

fn main() {
    let args = env::args().nth(1).unwrap();
    let input = fs::read_to_string(args).unwrap();
    println!("{}", input);
}
