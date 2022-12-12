package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
)

func main() {
	start, sum, fuelsum := 0, 0, 0
	if len(os.Args) < 2 {
		panic("runtime error: missing operand")
	}
	file, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	for i := 0; i < len(file); i++ {
		if file[i] == '\n' {
			arg, err := strconv.Atoi(string(file[start:i])) // i-1??
			if err != nil {
				panic(err)
			}
			start = i + 1
			sum += (arg / 3) - 2
			fuelsum += tyranny(arg)
		}
	}
	fmt.Println(sum)
	fmt.Println(fuelsum)
}

func tyranny(mass int) int {
	subtotal := 0
	for fuel := (mass / 3) - 2; fuel >= 0; fuel = (fuel / 3) - 2 {
		subtotal += fuel
	}
	return subtotal
}
