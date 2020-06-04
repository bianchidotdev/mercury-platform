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
	router.GET("/pingz", func(c *gin.Context) {
		c.String(http.StatusOK, "pong")
	})

	// Healthcheck endpoint
	healthz.Version = Version
	router.GET("/healthz", healthz.HealthGET)

	// Jobs
}

func main() {
	setupRouter()

	fmt.Println("Running version:", Version)
	// Listen and Server in 0.0.0.0:8080
	router.Run(":8080")
}
