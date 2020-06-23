package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
)

func main() {
	if len(os.Args) < 2 {
		panic("runtime error: missing operand")
	}
	file, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	image := sliceify(file, 25, 6, len(file)/(25*6))

	checksum(image)
	decode(image)
}

func sliceify(file []byte, width int, height int, depth int) [][][]int {
	var image [][][]int
	pointer := 0

	for i := 0; i < depth; i++ {
		var b [][]int
		for j := 0; j < height; j++ {
			var a []int
			for k := 0; k < width; k++ {
				element, err := strconv.Atoi(string(file[pointer]))
				if err != nil {
					panic(err)
				}
				a = append(a, element)
				pointer++
			}
			b = append(b, a)
		}
		image = append(image, b)
	}
	return image
}

func count(layer [][]int, val int) int {
	total := 0
	for i := 0; i < len(layer); i++ {
		for j := 0; j < len(layer[i]); j++ {
			if layer[i][j] == val {
				total++
			}
		}
	}
	return total
}

func checksum(image [][][]int) {
	min := count(image[0], 0)
	layer := -1
	for i := 0; i < len(image); i++ {
		total := count(image[i], 0)
		if total < min {
			min = total
			layer = i
		}
	}
	fmt.Println(count(image[layer], 1) * count(image[layer], 2))
}

func decode(image [][][]int) {
	for i := 0; i < len(image[0]); i++ {
		for j := 0; j < len(image[0][0]); j++ {
			for k := 0; k < len(image); k++ {
				if image[k][i][j] == 0 {
					fmt.Print(" ")
					break
				} else if image[k][i][j] == 1 {
					fmt.Print("X")
					break
				}
			}
		}
		fmt.Println()
	}
}
