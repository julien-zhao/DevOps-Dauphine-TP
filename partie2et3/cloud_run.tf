resource "google_cloud_run_service" "default" {
  name     = "wordpress"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/valid-song-441707-t2/wordpress:latest"
        ports {
          container_port = 80
        }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
