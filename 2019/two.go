package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
)

func main() {
	var slice []int
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
			slice = append(slice, arg)
			start = i + 1
			size++
		}
	}
	noun, verb := edocpo(slice, 19690720)
	slice[1] = 12
	slice[2] = 2
	fmt.Println(opcode(slice)[0])
	fmt.Println(100*noun + verb)
}

func opcode(slice []int) []int {
	for i := 0; i < len(slice); i += 4 {
		if slice[i] == 1 {
			slice[slice[i+3]] = slice[slice[i+1]] + slice[slice[i+2]]
		} else if slice[i] == 2 {
			slice[slice[i+3]] = slice[slice[i+1]] * slice[slice[i+2]]
		} else if slice[i] == 99 {
			return slice
		} else {
			fmt.Println("Unsupported code", slice[i], "at", i)
			os.Exit(0)
		}
	}
	return slice
}

func edocpo(slice []int, output int) (int, int) {
	var ecils []int
	for i := 0; i < len(slice); i++ {
		for j := 0; j < len(slice); j++ {
			ecils = append([]int(nil), slice...) // reset ecils to slice
			ecils[1], ecils[2] = i, j
			if opcode(ecils)[0] == output {
				return i, j
			}
		}
	}
	return -1, -1
}
