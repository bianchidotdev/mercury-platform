package jobcontroller

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// Version application version
var Version string

// https://tools.ietf.org/id/draft-inadarei-api-health-check-01.html
// We should use pass, fail, warn for this if possible

// Job structure of job object
type Job struct {
	ID   uint   `json:"id"`
	User string `json:"user"`
}

func GetJobs(c *gin.Context) {
	c.String(http.StatusOK, "GetJobs")
}

func GetJobByID(c *gin.Context) {
	id := c.Param("id")
	c.String(http.StatusOK, id)
}

func CreateJob(c *gin.Context) {
	var job Job
	c.BindJSON(&job)
	c.JSON(http.StatusOK, job)
}
