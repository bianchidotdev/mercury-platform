package main

import (
	"fmt"
	"jockey/pkg/healthz"
	jobcontroller "jockey/pkg/job_controller"

	"github.com/gin-gonic/gin"
)

var db = make(map[string]string)
var router *gin.Engine

func setupRouter() {
	// Disable Console Color
	// gin.DisableConsoleColor()
	router = gin.Default()

	api := router.Group("/api")
	{
		// Internal routes
		internal := api.Group("/merc")
		{
			// Health
			health := internal.Group("/healthz")
			{
				healthz.Version = Version
				health.GET("/", healthz.HealthGET)
				health.GET("/shallow", healthz.HealthGET)
				health.GET("/ping", healthz.PingGET)
				health.GET("/deep", healthz.DeepHealthGET)
			}
		}

		v1 := api.Group("/v1")
		{
			job := v1.Group("/jobs")
			{
				job.GET("/", jobcontroller.GetJobs)
				job.GET("/:id", jobcontroller.GetJobByID)
				job.POST("/", jobcontroller.CreateJob)
			}
		}
	}
}

func main() {
	setupRouter()

	fmt.Println("Running version:", Version)
	// Listen and Server in 0.0.0.0:8080
	router.Run(":8080")
}
