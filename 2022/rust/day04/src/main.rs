use std::env;
use std::fs;
use std::ops::RangeInclusive;

fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let assignments = input.trim().split('\n').map(|x| {
        let mut vec = x.split(['-',',']).map(|x| x.parse::<i32>().unwrap());
        return [vec.next().unwrap(), vec.next().unwrap(),
                vec.next().unwrap(), vec.next().unwrap()];
    }).collect::<Vec<[i32; 4]>>();

    println!("{}", assignments.iter()
        .filter(|x| contains(x[0] ..= x[1], x[2] ..= x[3])).count());

    println!("{}", assignments.iter()
        .filter(|x| overlaps(x[0] ..= x[1], x[2] ..= x[3])).count());
}

fn contains(a: RangeInclusive::<i32>, b: RangeInclusive::<i32>) -> bool {
    return b.contains(a.start()) && b.contains(a.end()) ||
           a.contains(b.start()) && a.contains(b.end());
}

fn overlaps(a: RangeInclusive::<i32>, b: RangeInclusive::<i32>) -> bool {
    return b.contains(a.start()) || b.contains(a.end()) ||
           a.contains(b.start()) || a.contains(b.end());
}

/*
fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let assignments = input.trim().split('\n')
        .map(|x| {x.split(['-',',']).collect()})
        .collect::<Vec<Vec<&str>>>();

    println!("{:?}", assignments);

}

*/
