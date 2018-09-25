package main

import (
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/gorilla/mux"
)

// our main function
func main() {
	router := mux.NewRouter()
	router.HandleFunc("/wait/{seconds}", func(w http.ResponseWriter, r *http.Request) {
		params := mux.Vars(r)
		pause, err := strconv.Atoi(params["seconds"])
		if err != nil {
			w.Write([]byte("seconds must be a number"))
			return
		}
		time.Sleep(time.Duration(pause) * time.Second)
	}).Methods("GET")
	log.Fatal(http.ListenAndServe(":8000", router))
}
