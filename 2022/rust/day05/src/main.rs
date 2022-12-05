use std::collections::VecDeque;
use std::env;
use std::fs;
use text_io::scan;

fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let mut parts = input.split("\n\n");

    let crates = parts.next().unwrap();
    // yes, it's gross. yes, it works. no, i couldn't think of anything better.
    let mut stacks: Vec<Vec<char>> = vec![];
    for i in 0..9 {
        let mut stack: Vec<char> = vec![];
        for j in 0..8 {
            stack.push(crates.chars().nth((9*4) * (7-j) + 4*i + 1).unwrap());
        }
        while *stack.last().unwrap() == ' ' {
            stack.pop();
        }
        stacks.push(stack);
    }

    let instructions: Vec<[usize; 3]> = parts.next().unwrap().trim().split("\n").map(|x| {
        let a: usize;
        let b: usize;
        let c: usize;
        scan!(x.bytes() => "move {} from {} to {}", a, b, c);
        return [a, b, c];
    }).collect(); // collect() still messes me up
    let capacity: usize = instructions.iter().fold(0, |x,y| x.max(y[0]));

    let mut stack = stacks.clone();
    for ins in &instructions {
        for _ in 0 .. ins[0] {
            let cargo = stack[ins[1]-1].pop().unwrap();
            stack[ins[2]-1].push(cargo);
        }
    }
    let answer: String = stack.iter().map(|x| x.last().unwrap()).collect();
    println!("{}", answer);

    let mut stack = stacks.clone();
    for ins in instructions {
        let mut cargo: VecDeque<char> = VecDeque::with_capacity(capacity);
        for _ in 0 .. ins[0] {
            cargo.push_front(stack[ins[1]-1].pop().unwrap());
        }
        stack[ins[2]-1].append(&mut cargo.into());
    }
    let answer: String = stack.iter().map(|x| x.last().unwrap()).collect();
    println!("{}", answer);
}
