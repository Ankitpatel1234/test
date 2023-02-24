provider "google" {
  project = "ankit-project"
  region  = "us-central1"
}

resource "google_compute_backend_service" "backend-service" {
  name        = "backend-service"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = "instance-group"
  }

  health_checks = ["health-check"]
}

resource "google_compute_forwarding_rule" "forwarding-rule" {
  name                  = "forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = "static-ip-address"
  port_range            = "80"
  protocol              = "TCP"

  backend_service = google_compute_backend_service.backend-service.self_link
}
