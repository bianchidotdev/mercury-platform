package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestPingRoute(t *testing.T) {
	setupRouter()

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("GET", "/merc/healthz/ping", nil)
	router.ServeHTTP(w, req)

	if status := w.Code; status != http.StatusOK {
		t.Errorf("endpoint returned wrong status code: got %v want %v", status, http.StatusOK)
	}
	if responseBody := w.Body.String(); responseBody != "pong" {
		t.Errorf("endpoint returned wrong body: got %s want %s", responseBody, "pong")
	}
}
