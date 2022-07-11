//module github.com/dm0610/gb-go-backend1-project
module gb-go-backend1-project

go 1.17

//replace github.com/dm0610/gb-go-backend1/tree/hw08/hw08/product_builder => ./
require (
	github.com/gorilla/mux v1.8.0
	github.com/lib/pq v1.10.6
)
