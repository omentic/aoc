package main

import (
	"io/ioutil"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		panic("runtime error: missing operand")
	}
	file, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}

	for i := 0
}

func orbits(planet string) []string {

	var chain []string

	return chain
}
