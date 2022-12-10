use std::cell::{Cell, RefCell};
use std::cmp;
use std::env;
use std::fs;
use std::rc::{Rc, Weak};

struct Directory {
    id: String,
    size: Cell<i32>,
    // mmm i'd rather have a plain Directory instead of Rc<Directory>
    // but i get "cannot move out of x which is behind a shared reference"
    children: RefCell<Vec<Rc<Directory>>>,
    parent: Option<Weak<Directory>>
}

fn main() {
    let args = env::args().nth(1).expect("missing input");
    let input = fs::read_to_string(args).unwrap();
    let history: Vec<&str> = input.trim().split("\n").collect();

    let root = Rc::new(Directory {
        id: String::from("/"),
        size: Cell::from(0),
        children: RefCell::from(Vec::new()),
        parent: None
    });

    let mut current = root.clone();
    for line in &history[1..] {
        let output = line.split(" ");
        match output.collect::<Vec<&str>>()[..] {
            ["$", "ls"] => {
                // println!("$ ls")
            },
            ["$", "cd", ".."] => {
                current = current.parent.clone().unwrap().upgrade().unwrap(); // lmao
                // println!("$ cd ..");
            },
            ["$", "cd", id] => {
                let mut next: Option<Rc<Directory>> = None;
                for i in &*current.children.borrow() {
                    if i.id == id {
                        next = Option::from(i.clone());
                        break;
                    }
                }
                current = next.unwrap();
                // println!("$ cd {}", id);
            },
            ["dir", id] => {
                (current.children.borrow_mut()).push(Rc::from(Directory {
                    id: String::from(id),
                    size: Cell::from(0),
                    children: RefCell::from(Vec::new()),
                    parent: Option::from(Rc::downgrade(&current))
                }));
                // println!("dir {}", id)
            },
            [size, id] => {
                current.size.replace(current.size.get() + size.parse::<i32>().unwrap());
                // println!("{} {}", size, id)
            },
            _ => panic!("crash and burn"),
        }
    }

    // Corrects directory sizes by adding the size of nested directories to the directory
    fn populate_size(a: &Rc<Directory>) {
        for i in &*a.children.borrow() {
            populate_size(&i);
            a.size.set(a.size.get() + i.size.get());
        }
    }
    populate_size(&root);

    const maximum_space: i32 = 100000;
    fn calc_size(a: &Rc<Directory>) -> i32 {
        let mut sum = 0;
        for i in &*a.children.borrow() {
            sum += calc_size(&i);
        }
        if a.size.get() <= maximum_space {
            sum += a.size.get();
        }
        return sum;
    }
    println!("{}", calc_size(&root));

    const total_space: i32 = 70000000;
    const update_space: i32 = 30000000;
    // no global variables?? O_O
    let needed_space = update_space - (total_space - root.size.get());
    fn calc_min(a: &Rc<Directory>, min: i32, need: i32) -> i32 {
        let mut min = min;
        if a.size.get() >= need {
            min = cmp::min(a.size.get(), min);
        }
        for i in &*a.children.borrow() {
            min = cmp::min(calc_min(&i, min, need), min);
        }
        return min;
    }
    println!("{}", calc_min(&root, update_space, needed_space));
}
