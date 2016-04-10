/*
The MIT License (MIT)

Copyright (c) 2016 Mark Roberts

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"sync"
)

var url string
var requestLimit int

const (
	defaultUrl    = "http://localhost:3000/"
	defaultMaxReq = 100
	headerName    = "X-Served-By"
)

func init() {
	flag.StringVar(&url, "url", defaultUrl, "Url to request")
	flag.IntVar(&requestLimit, "r", defaultMaxReq, "Maximum number of requests to make")
}

func main() {
	flag.Parse()

	hexOut := make(chan string)
	go printUnique(hexOut)
	var wg sync.WaitGroup
	wg.Add(requestLimit)
	for i := 0; i < requestLimit; i++ {
		go getHeader(hexOut, &wg)
	}
	wg.Wait()
	close(hexOut)
}

func printUnique(hexOut <-chan string) {
	found := make(map[string]int)
	for hex := range hexOut {
		found[hex]++
		if found[hex] == 1 {
			fmt.Println(hex)
		}
	}
}

func getHeader(hexOut chan<- string, wg *sync.WaitGroup) {
	defer wg.Done()
	resp, err := http.Head(url)
	if err != nil {
		log.Fatalln(err)
	}
	defer resp.Body.Close()
	header := resp.Header.Get(headerName)
	if header != "" {
		hexOut <- header
	}
}
