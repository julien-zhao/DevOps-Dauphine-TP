data "google_client_config" "default" {}

data "google_container_cluster" "my_cluster" {
  name     = "gke-dauphine"
  location = "us-central1-a"
}

provider "google" {
  project = "valid-song-441707-t2"
  region  = "us-central1"
}
