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

func split(memory []int, i, size int) (int, int, int) {
	mode := memory[i] / 100
	three, two, one := i+3, i+2, i+1
	if size-i > 1 {
		if mode%10 == 0 {
			one = memory[i+1]
		}
		if size-i > 2 {
			if mode/10%10 == 0 {
				two = memory[i+2]
			}
			if size-i > 3 {
				if mode/100 == 0 {
					three = memory[i+3]
				}
			}
		}
	}
	return three, two, one
}

func execute(memory []int, size int) []int {
	for i := 0; i < len(memory); {
		opcode := memory[i] % 100
		three, two, one := split(memory, i, size)
		switch opcode {
		case 1: // adds
			memory[three] = memory[one] + memory[two]
			i += 4
		case 2: // multiplies
			memory[three] = memory[one] * memory[two]
			i += 4
		case 3: // input
			var input int
			fmt.Print("Input: ")
			resp, err := fmt.Scanf("%d", &input)
			if err != nil {
				fmt.Println(resp, err)
				os.Exit(0)
			}
			memory[one] = input // not affected by modes
			i += 2
		case 4: // output
			fmt.Println(memory[one])
			i += 2
		case 5: // jump-if-true
			if memory[one] != 0 {
				i = memory[two] // ???
			} else {
				i += 3
			}
		case 6: // jump-if-false
			if memory[one] == 0 {
				i = memory[two] // ???
			} else {
				i += 3
			}
		case 7: // less than
			if memory[one] < memory[two] {
				memory[memory[i+3]] = 1
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
