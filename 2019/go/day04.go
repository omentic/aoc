package main

import (
	"fmt"
	"io/ioutil"
	"math"
	"os"
	"strconv"
)

func main() {
	smallest, largest, total, details := -1, -1, 0, 0
	if len(os.Args) < 2 {
		panic("runtime error: missing operand")
	}
	file, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	for i := 0; i < len(file); i++ {
		if string(file[i]) == "-" {
			smallest, err = strconv.Atoi(string(file[0:i]))
			if err != nil {
				panic(err)
			}
			largest, err = strconv.Atoi(string(file[i+1 : len(file)-1]))
			if err != nil {
				panic(err)
			}
			break
		}
	}

	for i := smallest; i <= largest; i++ {
		if criteria(i, false) {
			total++
		}
		if criteria(i, true) {
			details++
		}
	}
	fmt.Println(total)
	fmt.Println(details)
}

func criteria(password int, stage bool) bool {
	prev := 0
	for i := 0; i < 6; i++ {
		if password/int(math.Pow(10, float64(5-i)))%10 < prev {
			return false
		}
		prev = password / int(math.Pow(10, float64(5-i))) % 10
	}
	pascii := strconv.Itoa(password)
	for i := 0; i < len(pascii)-1; i++ {
		if string(pascii[i]) == string(pascii[i+1]) {
			if !(len(pascii)-i > 2 && string(pascii[i]) == string(pascii[i+2])) {
				if !stage { // Gross hack
					return true
				}
				if !(i > 0 && string(pascii[i]) == string(pascii[i-1])) {
					return true
				}
			}
		}
	}
	return false
}
