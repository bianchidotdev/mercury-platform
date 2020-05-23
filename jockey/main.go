package main

import (
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

	// Authorized group (uses gin.BasicAuth() middleware)
	// Same than:
	// authorized := r.Group("/")
	// authorized.Use(gin.BasicAuth(gin.Credentials{
	//	  "foo":  "bar",
	//	  "manu": "123",
	//}))
}

func main() {
	setupRouter()
	// Listen and Server in 0.0.0.0:8080
	router.Run(":8080")
}
