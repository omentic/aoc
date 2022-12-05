#![feature(iter_array_chunks)]
use std::env;
use std::fs;

fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let rucksacks = input.trim().split("\n");

    let compartments: Vec<(&str, &str)> = rucksacks.clone()
        .map(|x| x.split_at(x.len() / 2)).collect();
    let mut sum = 0;
    for (a, b) in compartments.iter() {
        for c in a.chars() {
            if b.contains(c) {
                sum += deascii(c);
                break;
            }
        }
        // println!("{:?}, {:?}", a, b);
    }
    println!("{}", sum);

    sum = 0;
    // yoo this is sick
    for a in rucksacks.array_chunks::<3>() {
        for c in a[0].chars() {
            if a[1].contains(c) && a[2].contains(c) {
                sum += deascii(c);
                break;
            }
        }
    }
    println!("{}", sum);
}

fn deascii(x: char) -> i64 {
    if x as i64 > 96 {
        return x as i64 - 96;
    } else {
        return x as i64 - 38;
    }
}
