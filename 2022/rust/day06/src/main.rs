use std::collections::HashSet;
use std::env;
use std::fs;

fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let signal: Vec<char> = input.trim().chars().collect();

    let depth = 4;
    for (i, c) in signal.windows(depth).enumerate() {
        // why can rust not infer the type of HashSet?
        // https://stackoverflow.com/questions/62949404/
        if HashSet::<_>::from_iter(c).len() == depth {
            println!("{}", i + depth);
            break;
        }
    }

    let depth = 14;
    for (i, c) in signal.windows(depth).enumerate() {
        if HashSet::<_>::from_iter(c).len() == depth {
            println!("{}", i + depth);
            break;
        }
    }
}
