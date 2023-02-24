provider "google" {
  project = "ankit-project"
  region  = "us-central1"
}

# Create a new virtual machine instance
resource "google_compute_instance" "web-server" {
  name         = "web-server"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "my-network"
    
  }

  metadata_startup_script = <<-EOF
    # Install Apache web server
    apt-get update
    apt-get install -y apache2

    # Copy the frontend files to the web server
    gsutil -m cp -r gs://your-bucket-name/* /var/www/html/
  EOF
}

# Create a firewall rule to allow HTTP traffic
resource "google_compute_firewall" "web-server-firewall" {
  name    = "web-server-firewall"
  network = "my-network"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

