package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func main() {
	var region [][]bool
	x, y, size := 0, 0, 0
	if len(os.Args) < 2 {
		panic("runtime error: missing operand")
	}
	file, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	for i := 0; i < len(file); i++ {
		if file[i] == '#' {
			region[x][y] = true
			x++
		} else if file[i] == '\n' {
			x = 0
			y++
		}
	}
	max := 0
	fmt.Println("Maximum detectable asteroids:", detect(region, x, y))
}

func detect(region [][]bool, width, height int) int {
	for i:= 0; i < width; i++ {
		for j := 0; j < height; j++ {
			if region[i][j] {
				for k:= 0; k < width; k++ {
					for l := 0; l < width; l++ {

					}
				}
			}
		}
	}

	slope :=
	return
}
