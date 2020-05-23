package healthz

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gin-gonic/gin"
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

	if status := w.Code; status != http.StatusOK {
		t.Errorf("endpoint returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

	statusKey := "status"
	expectedBody := gin.H{
		statusKey: "pass",
	}
	// Convert the JSON response to a map
	var response map[string]string
	err := json.Unmarshal([]byte(w.Body.String()), &response)
	if err != nil {
		t.Errorf("error unmarshalling response into hashmap %s", err)
	}

	// Grab the value & whether or not it exists
	value, exists := response[statusKey]
	if exists != true {
		t.Errorf("key %s not found in response map - %s", statusKey, response)
	}
	if expectedBody[statusKey] != value {
		t.Errorf("endpoint returned wrong status: got %s want %s", expectedBody[statusKey], value)
	}
}
