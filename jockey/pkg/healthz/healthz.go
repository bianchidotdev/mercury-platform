package healthz

import "github.com/gin-gonic/gin"

// https://tools.ietf.org/id/draft-inadarei-api-health-check-01.html
// We should use pass, fail, warn for this if possible

func HealthGET(c *gin.Context) {
	c.JSON(200, gin.H{
		"status": "pass",
	})
}
