package healthz

import (
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"reflect"
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
	resp := httptest.NewRecorder()
	req, err := http.NewRequest("GET", "/healthz", nil)
	if err != nil {
		t.Fatal(err)
	}
	router.ServeHTTP(resp, req)

	assertStatus(t, resp.Code, http.StatusOK)

	wantedHealthResponse := HealthResponse{
		"pass",
		[]string{},
		"",
	}

	got := getHealthResponse(t, resp.Body)
	assertHealthResponse(t, got, wantedHealthResponse)
}

func assertStatus(t *testing.T, got, want int) {
	t.Helper()
	if got != want {
		t.Errorf("did not get correct status, got %d, want %d", got, want)
	}
}

func getHealthResponse(t *testing.T, body io.Reader) (health HealthResponse) {
	t.Helper()
	err := json.NewDecoder(body).Decode(&health)

	if err != nil {
		t.Fatalf("Unable to parse response from server %q into HealthResponse, '%v'", body, err)
	}

	return
}

func assertHealthResponse(t *testing.T, got, want HealthResponse) {
	t.Helper()
	if !reflect.DeepEqual(got, want) {
		t.Errorf("got %v want %v", got, want)
	}
}
