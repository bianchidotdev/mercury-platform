package healthz

import (
	"github.com/gin-gonic/gin"
)

// Version application version
var Version string

// https://tools.ietf.org/id/draft-inadarei-api-health-check-01.html
// We should use pass, fail, warn for this if possible

// HealthResponse structure of healthcheck response
type HealthResponse struct {
	Status  string   `json:"status"`
	Errors  []string `json:"errors"`
	Version string   `json:"version"`
}

// HealthGET responds with the health of the server
func HealthGET(c *gin.Context) {
	resp := HealthResponse{
		"pass",
		[]string{},
		Version,
	}

	c.JSON(200, resp)
}
