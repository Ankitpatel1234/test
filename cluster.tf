provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a new GKE cluster
resource "google_container_cluster" "cluster" {
  name               = "cluster-name"
  location           = "us-central1-a"
  remove_default_node_pool = true

  node_pool {
    name = "node-pool-name"
    initial_node_count = 1
    machine_type = "n1-standard-2"
    disk_size_gb = 20
  }
}
