package main

import (
	"fmt"
	"jockey/pkg/healthz"
	"net/http"

	"github.com/gin-gonic/gin"
)

var db = make(map[string]string)
var router *gin.Engine

func setupRouter() {
	// Disable Console Color
	// gin.DisableConsoleColor()
	router = gin.Default()

	// Ping test
	router.GET("/ping", func(c *gin.Context) {
		c.String(http.StatusOK, "pong")
	})

	healthz.Version = Version
	router.GET("/healthz", healthz.HealthGET)

	// Get user value
	router.GET("/user/:name", func(c *gin.Context) {
		user := c.Params.ByName("name")
		value, ok := db[user]
		if ok {
			c.JSON(http.StatusOK, gin.H{"user": user, "value": value})
		} else {
			c.JSON(http.StatusOK, gin.H{"user": user, "status": "no value"})
		}
	})
}

func main() {
	setupRouter()

	fmt.Println("Running version:", Version)
	// Listen and Server in 0.0.0.0:8080
	router.Run(":8080")
}
