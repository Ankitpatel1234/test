provider "google" {
  project = "your-project-id"
  region  = "us-central"
}

# Create a new App Engine application
resource "google_app_engine_application" "app" {
  project = "your-project-id"
}

# Create a new App Engine standard environment service
resource "google_app_engine_standard_app_version" "app-version" {
  service         = "default"
  runtime         = "nodejs14"
  entrypoint {
    shell = "node server.js"
  }
  env_variables = {
    PORT = "8080"
  }
  deployment {
    zip {
      source_url = "gs://your-bucket-name/app.zip"
    }
  }
}

# Create a new App Engine standard environment firewall rule
resource "google_app_engine_firewall_rule" "app-firewall" {
  action  = "allow"
  priority = 1000
  source_range = "0.0.0.0/0"
  target = "INGRESS"
  description = "Allow HTTP traffic from anywhere."
}

# Create a Cloud Storage bucket to store the frontend files
resource "google_storage_bucket" "frontend-bucket" {
  name     = "your-bucket-name"
  location = "US"
}

# Upload the frontend files to the Cloud Storage bucket
resource "google_storage_bucket_object" "frontend-files" {
  name   = "index.html"
  bucket = google_storage_bucket.frontend-bucket.name
  source = "index.html"
}

# Create a load balancer to serve the frontend
resource "google_compute_global_forwarding_rule" "frontend-load-balancer" {
  name       = "frontend-load-balancer"
  ip_address = "your-static-ip-address"
  port_range = "80"
  target     = "your-backend-service-self-link"
}

# Create a backend service to serve the frontend
resource "google_compute_backend_service" "frontend-backend-service" {
  name        = "frontend-backend-service"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = "your-instance-group-name"
  }

  health_checks = ["your-health-check-name"]
}

# Create an instance group to serve the frontend
resource "google_compute_instance_group" "frontend-instance-group" {
  name = "frontend-instance-group"
  zone = "us-central1-a"

  named_port {
    name = "http"
    port = 8080
  }

  instance_template = "your-instance-template-self-link"

  target_size = 1
}
