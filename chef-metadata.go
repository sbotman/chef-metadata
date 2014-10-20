package main

import (
	"crypto/md5"
	"crypto/sha256"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"path/filepath"
	"regexp"
	"sort"
	"strconv"
)

var (
	srvPath   = flag.String("path", "", "Path to chef client sources")
	srvIP     = flag.String("address", "127.0.0.1", "IP for the service")
	srvPort   = flag.String("port", "8090", "Port for the service")
	srvURL    = flag.String("url", "http://your.server.com", "URL for the client download location")
)


// Add type and functions for the Sort interface
type files []string

func (f files) Len() int {
	return len(f)
}

func (f files) Less(i, j int) bool {
	re := regexp.MustCompile(`.*?(\d+)\.(\d+)\.(\d+)-?(\d+)?.*`)
	parts_i := re.FindStringSubmatch(f[i])
	parts_j := re.FindStringSubmatch(f[j])

	for idx := 1; i < len(parts_i); i++ {
		// Convert the part to a int
		i, err := strconv.Atoi(parts_i[idx])
		if err != nil {
			return false
		}
		// Convert the part to a int
		j, err := strconv.Atoi(parts_j[idx])
		if err != nil {
			return false
		}
		// Compare and do a descending sort
		if j < i {
			return true
		}
	}
	return false
}

func (f files) Swap(i, j int) {
	f[i], f[j] = f[j], f[i]
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Chef Client Distribution Handler v0.1.4")
}

func getURLParamsPaht(r *http.Request) string {
	return filepath.Join(r.FormValue("p"), r.FormValue("pv"), r.FormValue("m"))
}

func getTargetDir(r *http.Request) string {
	params := getURLParamsPaht(r)

	dir, err := filepath.Abs(params)
        if err != nil {
                log.Fatal(err)
        }

       if *srvPath != "" {
                dir = filepath.Join(*srvPath, params)
        }
	return dir
}


func getTargetFile(r *http.Request) string {
	dir  := getTargetDir(r)

	version := r.FormValue("v")
        if version == "latest" {
                version = "."
        }
	
        filelist, _ := filepath.Glob(dir + "/*" + version + "*")

        if filelist != nil {
                sort.Sort(files(filelist))
                return filelist[0]
	} else {
		return ""
	}
}

func getTargetURL(target string) string {
	return *srvURL + "/" + target
}


func downloadHandler(w http.ResponseWriter, r *http.Request) {
	path := getURLParamsPaht(r)
	dir  := getTargetDir(r)

	targetfile := getTargetFile(r)

	if targetfile != "" {
		targetpath := path + targetfile[len(dir):]
        	targeturl  := getTargetURL(targetpath)
		http.Redirect(w, r, targeturl, http.StatusFound)
	}
}

func metadataHandler(w http.ResponseWriter, r *http.Request) {
	path := getURLParamsPaht(r)
        dir  := getTargetDir(r)

        targetfile := getTargetFile(r)

	if targetfile != "" {
        	targetpath := path + targetfile[len(dir):]
        	targeturl  := getTargetURL(targetpath)

		data, err := ioutil.ReadFile(targetfile)
		if err != nil {
			log.Fatal(err)
		}

		targetmd5 := md5.Sum(data)
		targetsha := sha256.Sum256(data)
		data = nil

		fmt.Fprintf(w, "url %s md5 %x sha256 %x", targeturl, targetmd5, targetsha)
	}
}

func main() {
	flag.Parse()
	http.HandleFunc("/", handler)
	http.HandleFunc("/chef/metadata", metadataHandler)
	http.HandleFunc("/chef/download", downloadHandler)
	address := *srvIP + ":" + *srvPort
	http.ListenAndServe(address, nil)
}
