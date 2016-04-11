/* Copyright (c) 2016 Mark Roberts
   Released under the MIT license. See the file LICENSE for details.
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
var concurrentTasks int

const (
	defaultUrl    = "http://localhost:3000/"
	defaultMaxReq = 100
	defaultConcurrentTasks = 8
	headerName    = "X-Served-By"
)

func init() {
	flag.StringVar(&url, "url", defaultUrl, "Url to request")
	flag.IntVar(&requestLimit, "r", defaultMaxReq, "Maximum number of requests to make")
	flag.IntVar(&concurrentTasks, "c", defaultConcurrentTasks, "Number of HTTP requests to make concurrently")
}

func main() {
	flag.Parse()

	work := make(chan int)
	hexOut := make(chan string)
	go printUnique(hexOut)
	var wg sync.WaitGroup
	wg.Add(concurrentTasks)
	for i := 0; i < concurrentTasks; i++ {
		go requestWorker(hexOut, work, &wg)
	}
	for i := 0; i < requestLimit; i++ {
		work <- 1
	}
	close(work)
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

func requestWorker(hexOut chan<- string, work <-chan int, wg *sync.WaitGroup) {
	defer wg.Done()
	for _ = range work {
		getHeader(hexOut)
	}
}

func getHeader(hexOut chan<- string) {
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
