package main

import (
    "io/ioutil"
    "crypto/md5"
    "crypto/sha256"
    "fmt"
    "log"
    "sort"
    "net/http"
    "path/filepath"
    "flag"
)

var (
	srvPath   = flag.String("path", "", "Path to chef client sources")
	srvIP     = flag.String("address", "127.0.0.1", "IP for the service")
	srvPort   = flag.String("port", "8090", "Port for the service")
	srvURL    = flag.String("url", "http://your.server.com", "URL for the client download location")
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Chef Client Distribution Point")
}


func metadataHandler(w http.ResponseWriter, r *http.Request) {
  if r.URL.Path[1:] == "chef/metadata" {
    version := r.FormValue("v")
    product := r.FormValue("p")
    prodver := r.FormValue("pv")
    machine := r.FormValue("m")
    path := filepath.Join("client", product, prodver, machine)   

    dir, err := filepath.Abs(path)
    if err != nil {
      log.Fatal(err)
    }

    if *srvPath != "" { 
      dir = filepath.Join(*srvPath, path) 
    }

    if version == "latest" {
      version = "."
    }

    filelist, _ := filepath.Glob(dir + "/*" + version + "*")

    if filelist != nil {
      sort.Strings(filelist)
      target := filelist[len(filelist) - 1]
      targetpath := path + target[len(dir):]
 
      data, err := ioutil.ReadFile(target)
      if err != nil {
        log.Fatal(err)
      } 

      targetmd5 := md5.Sum(data)
      targetsha5 := sha256.Sum256(data)
      data = nil

      fmt.Fprintf(w, "url %s md5 %x sha256 %x", filepath.Join(*srvURL, targetpath), targetmd5, targetsha5)
    }
    
  } else {
    fmt.Fprintf(w, "Path: %s", r.URL.Path[1:] )
  }
}

func main() {
    flag.Parse()
    http.HandleFunc("/", handler)
    http.HandleFunc("/chef/", metadataHandler)
    address := *srvIP + ":" + *srvPort
    http.ListenAndServe(address, nil)
}
