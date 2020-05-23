package healthz

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/assert"
)

var router *gin.Engine

func setupRouter() {
	// Disable Console Color
	// gin.DisableConsoleColor()
	router = gin.Default()

	// Ping test
	router.GET("/healthz", HealthGET)
}

func TestHealthGET(t *testing.T) {
	setupRouter()
	w := httptest.NewRecorder()
	req, _ := http.NewRequest("GET", "/healthz", nil)
	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusOK, w.Code)

	body := gin.H{
		"status": "pass",
	}
	// Convert the JSON response to a map
	var response map[string]string
	err := json.Unmarshal([]byte(w.Body.String()), &response)
	// Grab the value & whether or not it exists
	value, exists := response["status"]
	// Make some assertions on the correctness of the response.
	assert.Nil(t, err)
	assert.True(t, exists)
	assert.Equal(t, body["status"], value)
}
