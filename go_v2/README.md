#Go
This is an attempt at an idiomatic Go implementation. It makes a number of HTTP HEAD requests concurrently, feeding the results back through a channel to function that finds and prints the unique header values as they come in.

##Building it
````sh
go_v2 $ go build xservedby.go
````

##Running it
````sh
go_v2 $ ./xservedby -h
````