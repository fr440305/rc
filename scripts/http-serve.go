package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strconv"
)

func listenToPort(portString string) (net.Listener, bool) {
	listener, err := net.Listen("tcp", ":" + portString)
	if err != nil {
		return nil, false
	}
	return listener, true
}

func searchAvailablePortAndListen(starts int) (net.Listener, string) {
	var port = starts
	var portString string
	for {
		portString = strconv.Itoa(port)
		listener, isPortAvailable := listenToPort(portString)
		if isPortAvailable {
			return listener, portString
		}
		port += 1
	}
	return nil, ""
}

func getPrivateIPAddress() string {
	ifaces, err := net.Interfaces()
	if err != nil {
		return ""
	}
	for _, i := range ifaces {
		addrs, err := i.Addrs()
		if err != nil {
			continue
		}
		for _, addr := range addrs {
			var ip net.IP
			switch v := addr.(type) {
			case *net.IPNet:
				ip = v.IP
			case *net.IPAddr:
				ip = v.IP
			}
			if ip.IsPrivate() {
				return ip.String()
			}
		}
	}
	return ""
}

func main() {
	listener, portString := searchAvailablePortAndListen(9090)
	privateIPAddress := getPrivateIPAddress()
	fmt.Println("Serving: " + os.Getenv("PWD"))
	fmt.Println("- Local  : 127.0.0.1:" + portString)
	fmt.Println("- Private: " + privateIPAddress + ":" + portString)
	http.Handle("/", http.FileServer(http.Dir(".")))
	log.Fatal(http.Serve(listener, nil))
}
