package main

import (
    "io/ioutil"
    "crypto/md5"
    "crypto/sha256"
    "fmt"
    "os"
    "log"
    "sort"
    "net/http"
    "path/filepath"
)

const filechunk = 8192    // we settle for 8KB

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
    if len(os.Args) >= 2 { 
      dir = filepath.Join(os.Args[1], path) 
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

      fmt.Fprintf(w, "url http://artifacts.schubergphilis.com/chef/%s md5 %x sha256 %x", targetpath, targetmd5, targetsha5)
    }
    
  } else {
    fmt.Fprintf(w, "Path: %s", r.URL.Path[1:] )
  }
}

func main() {
    http.HandleFunc("/", handler)
    http.HandleFunc("/chef/", metadataHandler)
    http.ListenAndServe(":8080", nil)
}


