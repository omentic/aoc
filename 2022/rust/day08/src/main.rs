use std::env;
use std::fs;

#[derive(Debug)]
struct Tree {
    height: i32,
    visible: bool,
    scenic: i32
}

#[allow(unused_parens)]
fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let mut forest: Vec<Vec<Tree>> = input.trim().split("\n")
        .map(|x| x.chars()
            .map(|x| Tree {
                height: x.to_digit(10).unwrap() as i32,
                visible: false,
                scenic: 1
            }).collect()).collect();

    let mut sum = 0;
    let mut max = 0;
    let len = forest.len();

    // not thrilled with this code.
    for i in 0 .. forest.len() {
        let mut min = (-1, -1, -1, -1);
        for j in 0 .. forest.len() {
            let k = forest[0].len() - 1 - j;

            if forest[i][j].height > min.0 {
                min.0 = forest[i][j].height;
                if !forest[i][j].visible {
                    sum += 1;
                }
                forest[i][j].visible = true;
            }
            if forest[i][k].height > min.1 {
                min.1 = forest[i][k].height;
                if !forest[i][k].visible {
                    sum += 1;
                }
                forest[i][k].visible = true;
            }
            if forest[j][i].height > min.2 {
                min.2 = forest[j][i].height;
                if !forest[j][i].visible {
                    sum += 1;
                }
                forest[j][i].visible = true;
            }
            if forest[k][i].height > min.3 {
                min.3 = forest[k][i].height;
                if !forest[k][i].visible {
                    sum += 1;
                }
                forest[k][i].visible = true;
            }

            let min = forest[i][j].height;
            forest[i][j].scenic *= gaze(&forest, (i..=i), (j+1..len), min);
            forest[i][j].scenic *= gaze(&forest, (i+1..len), (j..=j), min);
            forest[i][j].scenic *= gaze(&forest, (i..=i), (0..j).rev(), min);
            forest[i][j].scenic *= gaze(&forest, (0..i).rev(), (j..=j), min);

            if forest[i][j].scenic > max {
                max = forest[i][j].scenic;
            }

        }
    }
    println!("{}", sum);
    println!("{}", max);
}

// bluh why are range and rangeinclusive separate types
// bluhhh why are types not directly generic-able
// bluhhhhhh https://kaylynn.gay/blog/post/rust_ranges_and_suffering

// all things considered i'm happy with this function
// considering how many Interesting behaviors of rust i ran into on the way
fn gaze(forest: &Vec<Vec<Tree>>, x: impl Iterator<Item=usize>,
        y: impl Iterator<Item=usize> + Clone, min: i32) -> i32 {
    let mut count = 0;
    for i in x {
        for j in y.clone() {
            count += 1;
            if forest[i][j].height >= min {
                return count;
            }
        }
    }
    return count;
}
