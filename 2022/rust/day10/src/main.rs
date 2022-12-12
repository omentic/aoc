use std::env;
use std::fs;

#[derive(Eq, PartialEq)]
enum Ins {
    Noop,
    Addr(i32)
}

fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();

    let instructions: Vec<Ins> = input.trim().split("\n")
        .map(|x| {
            if x == "noop" {
                return Ins::Noop;
            } else {
                let val = x.split_whitespace().nth(1).unwrap();
                return Ins::Addr(val.parse::<i32>().unwrap());
            }
        }).collect();

    let mut sum = 0;
    let mut clock = 1;
    let mut register = 1;

    for ins in instructions {
        render(&clock, &register);
        tick(&mut clock);
        compare(&clock, &register, &mut sum);
        if let Ins::Addr(x) = ins {
            render(&clock, &register);
            tick(&mut clock);
            write(&mut register, x);
            compare(&clock, &register, &mut sum);
        }
    }
    println!("{}", sum);
}

fn render(clock: &i32, register: &i32) {
    if i32::abs(register - ((clock-1) % 40)) < 2 {
        print!("#");
    } else {
        print!(".");
    }
    if clock % 40 == 0 {
        print!("\n");
    }
}

fn tick(clock: &mut i32) {
    *clock += 1;
}

fn compare(clock: &i32, register: &i32, sum: &mut i32) {
    if clock % 40 == 20 {
        *sum += *register * *clock;
    }
}

fn write(register: &mut i32, value: i32) {
    *register += value;
}
