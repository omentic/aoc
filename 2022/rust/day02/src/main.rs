use std::env;
use std::fs;

fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let moves = input.trim().split("\n").map(|x| {
        let mut vec = x.split(" ");
        return (vec.next().unwrap(), vec.next().unwrap());
    }).collect::<Vec<(&str, &str)>>();

    let mut sum = 0;
    // note: without the iter "moves" is implicitly moved into the loop
    for i in moves.iter() {
        match i {
            // (x, "X") => sum += 1,
            ("A", "X") => sum += 3 + 1,
            ("B", "X") => sum += 0 + 1,
            ("C", "X") => sum += 6 + 1,
            // (x, "Y") => sum += 2,
            ("A", "Y") => sum += 6 + 2,
            ("B", "Y") => sum += 3 + 2,
            ("C", "Y") => sum += 0 + 2,
            // (x, "Z") => sum += 3,
            ("A", "Z") => sum += 0 + 3,
            ("B", "Z") => sum += 6 + 3,
            ("C", "Z") => sum += 3 + 3,
            _ => ()
        }
    }
    println!("{}", sum);

    sum = 0;
    for i in moves.iter() {
        match i {
            // (x, "X") => sum += 1,
            ("A", "X") => sum += 3 + 0,
            ("B", "X") => sum += 1 + 0,
            ("C", "X") => sum += 2 + 0,
            // (x, "Y") => sum += 2,
            ("A", "Y") => sum += 1 + 3,
            ("B", "Y") => sum += 2 + 3,
            ("C", "Y") => sum += 3 + 3,
            // (x, "Z") => sum += 3,
            ("A", "Z") => sum += 2 + 6,
            ("B", "Z") => sum += 3 + 6,
            ("C", "Z") => sum += 1 + 6,
            _ => ()
        }
    }
    println!("{}", sum);
}
