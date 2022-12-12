package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
)

func main() {
	var memory []int
	start, size := 0, 0
	if len(os.Args) < 2 {
		panic("runtime error: missing operand")
	}
	file, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	for i := 0; i < len(file); i++ {
		if file[i] == ',' || file[i] == '\n' {
			arg, err := strconv.Atoi(string(file[start:i])) // i-1??
			if err != nil {
				panic(err)
			}
			memory = append(memory, arg)
			start = i + 1
			size++
		}
	}
	// fmt.Println(execute(memory, size))
	// noun, verb := etucexe(memory, size, 19690720)
	// fmt.Println(100*noun + verb)
	execute(memory, size)
}

func split(memory []int, i, size, relative int) (int, int, int) {
	mode := memory[i] / 100
	three, two, one := i+3, i+2, i+1
	if size-i > 1 {
		if mode%10 == 0 {
			one = memory[i+1]
		} else if mode%10 == 2 {
			one = relative + memory[i+1]
		}
		if size-i > 2 {
			if mode/10%10 == 0 {
				two = memory[i+2]
			} else if mode%10 == 2 {
				two = relative + memory[i+2]
			}
			if size-i > 3 {
				if mode/100 == 0 {
					three = memory[i+3]
				} else if mode%10 == 2 {
					three = relative + memory[i+3]
				}
			}
		}
	}
	return three, two, one
}

func execute(memory []int, size int) []int {
	/* todo: said "memory" functionality could be [pos, value]int
	* i.e. when memory outside initial bounds wants to be accessed,
	* it writes to a new element of this slice
	* to access elements of the array, iterate through while checking each position
	* additionally, to ensure there aren't conflicting "positions" in the array,
	* do the above iteration process, if not, appends (this requires a total int)
	 */
	/*
		var swap [][2]int
	*/

	// off-topic todo: https://www.golangprograms.com/example-arrays-of-arrays-arrays-of-slices-slices-of-arrays-and-slices-of-slices.html
	// does this mean i can remove total / size because if so YES
	for i := 0; i < 4000; i++ { // bad (example: no auto-termination due to 0 replacing nothingness)
		memory = append(memory, 0)
	}
	relative := 0 // initial value of the relative base
	for i := 0; i < len(memory); {
		// bounds check
		opcode := memory[i] % 100
		three, two, one := split(memory, i, size, relative)
		//fmt.Println("test:", opcode)
		// actually what might work better than replacing all below would be
		// checking if the next three values are out of bounds or not
		// and then replacing them
		// no bad idea large addition exists
		switch opcode {
		case 1: // adds
			memory[three] = memory[one] + memory[two]
			i += 4
		case 2: // multiplies
			// if out of bounds
			// swap = append(swap, {memory[three], memory[one] * memory[two]})
			// else
			memory[three] = memory[one] * memory[two]
			i += 4
		case 3: // input
			var input int
			fmt.Print("Input: ")
			resp, err := fmt.Scanf("%d", &input) // interesting note: anything following a valid integer is run by bash
			if err != nil {
				fmt.Println(resp, err)
				os.Exit(0)
			}
			// out of bounds check
			memory[one] = input // not affected by modes
			i += 2
		case 4: // output
			fmt.Println(memory[one])
			i += 2
		case 5: // jump-if-true
			if memory[one] != 0 {
				i = memory[two]
			} else {
				i += 3
			}
		case 6: // jump-if-false
			if memory[one] == 0 {
				i = memory[two]
			} else {
				i += 3
			}
		case 7: // less than
			if memory[one] < memory[two] {
				memory[memory[i+3]] = 1 // instructions: _position_ given by the third parameter
			} else {
				memory[memory[i+3]] = 0
			}
			i += 4
		case 8: // equals
			if memory[one] == memory[two] {
				memory[memory[i+3]] = 1
			} else {
				memory[memory[i+3]] = 0
			}
			i += 4
		case 9: // adjusts the relative base
			relative += memory[one] // interesting behavior when changing to i+1
			i += 2
		case 99: // terminate
			return memory
		default:
			fmt.Println("Unsupported code", opcode, "at", i)
			os.Exit(0)
		}
	}
	return memory
}

func etucexe(memory []int, size, output int) (int, int) {
	var volatile []int
	for i := 0; i < len(memory); i++ {
		for j := 0; j < len(memory); j++ {
			volatile = append([]int(nil), memory...) // reset volatile to memory
			volatile[1], volatile[2] = i, j
			if execute(volatile, size)[0] == output {
				return i, j
			}
		}
	}
	return -1, -1
}
