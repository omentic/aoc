package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func main() {
	var directions [][]string
	var temp []string
	start := 0

	if len(os.Args) < 2 {
		panic("runtime error: missing operand")
	}
	file, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	for i := 0; i < len(file); i++ {
		if string(file[i]) == "," || file[i] == '\n' {
			temp = append(temp, string(file[start:i]))
			start = i + 1
			if file[i] == '\n' {
				directions[] = append(directions[], temp)
				temp = nil
			}
		}
	}
	fmt.Println(directions)

	// grid [][]int := boolgrid(directions)

}

// 	ax, ay, at := taxi(directions[0])
// 	bx, by, bt := taxi(directions[1])
// 	for i := 0; i < at; i++ {
// 		for j := 0; j < at; j++ {
// 			for k := 0; k <
// 			ax[i][j]
// 		}
// 	}
// 	abx, aby

// 	grid = taxi(directions, taxi(directions2, grid))
// 	min, x, y := 4000, 0, 0
// 	for i := 0; i < len(grid); i++ {
// 		for j := 0; j < len(grid); j++ {
// 			x, y = int(math.Abs(float64(i-500))), int(math.Abs(float64(j-500)))
// 			if grid[i][j] == 2 && x+y < min {
// 				fmt.Println(i-500, j-500)
// 				min = x + y
// 			}

// 		}
// 	}
// 	fmt.Println("Manhattan distance to intersection:", min)
// }

// func taxi(directions []string) ([]int, []int, int) {
// 	var horislice, vertslice []int
// 	total := 0
// 	for i := 0; i < len(directions); i++ {
// 		direction := directions[i][0]
// 		displacement, err := strconv.Atoi(directions[i][1:])
// 		if err != nil {
// 			panic(err)
// 		}
// 		switch direction {
// 		case 'L':
// 			for j := 0; j < displacement; j++ {
// 				horislice = append(horislice, horislice[total]-j)
// 				vertslice = append(vertslice, vertslice[total])
// 				total++
// 			}
// 		case 'R':
// 			for j := 0; j < displacement; j++ {
// 				horislice = append(horislice, horislice[total]+j)
// 				vertslice = append(vertslice, vertslice[total])
// 				total++
// 			}
// 		case 'U':
// 			for j := 0; j < displacement; j++ {
// 				vertslice = append(vertslice, vertslice[total]+j)
// 				horislice = append(horislice, horislice[total])
// 				total++
// 			}
// 		case 'D':
// 			for j := 0; j < displacement; j++ {
// 				vertslice = append(vertslice, vertslice[total]-j)
// 				horislice = append(horislice, horislice[total])
// 				total++
// 			}
// 		default:
// 			fmt.Println("Unhandled direction", string(direction))
// 			os.Exit(0)
// 		}
// 	}
// 	return horislice, vertslice, total
// }

// func taxi(directions []string, grid [4000][4000]int) [4000][4000]int { // sign convention: an array, left to right, top to bottom, beginning in the top left corner
// 	x, y := len(grid)/2, len(grid[0])/2 // start in center
// 	var boolgrid [4000][4000]bool
// 	for i := 0; i < len(directions); i++ {
// 		direction := directions[i][0]
// 		displacement, err := strconv.Atoi(directions[i][1:])
// 		if err != nil {
// 			panic(err)
// 		}
// 		switch direction {
// 		case 'L':
// 			for j := 0; j < displacement; j++ {
// 				x--
// 				if !boolgrid[x][y] {
// 					boolgrid[x][y] = true
// 				}
// 			}
// 		case 'R':
// 			for j := 0; j < displacement; j++ {
// 				x++
// 				if !boolgrid[x][y] {
// 					boolgrid[x][y] = true
// 				}
// 			}
// 		case 'U':
// 			for j := 0; j < displacement; j++ {
// 				y--
// 				if !boolgrid[x][y] {
// 					boolgrid[x][y] = true
// 				}
// 			}
// 		case 'D':
// 			for j := 0; j < displacement; j++ {
// 				y++
// 				if !boolgrid[x][y] {
// 					boolgrid[x][y] = true
// 				}
// 			}
// 		default:
// 			fmt.Println("Unhandled direction", string(direction))
// 			os.Exit(0)
// 		}
// 		fmt.Println(string(direction), displacement, x, y)
// 	}
// 	for i := 0; i < len(grid); i++ {
// 		for j := 0; j < len(grid[0]); j++ {
// 			if boolgrid[i][j] {
// 				grid[i][j]++
// 			}
// 		}
// 	}
// 	return grid // each element is equal to the numbers of wires on it
// }
