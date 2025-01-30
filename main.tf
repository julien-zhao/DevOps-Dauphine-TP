# Fournisseur Google Cloud
provider "google" {
  project = "valid-song-441707-t2"  # Votre ID de projet GCP
  region  = "us-central1"  # La région à définir pour d'autres ressources si nécessaire
}

# Configurer le backend GCS pour le state Terraform
terraform {
  backend "gcs" {
    bucket = "valid-song-441707-t2-tfstate"  # Remplacez par votre bucket GCS pour le state
    prefix = "terraform/state"
  }
}

# Activer les APIs nécessaires
resource "google_project_service" "cloudresourcemanager" {
  project = "valid-song-441707-t2"
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "serviceusage" {
  project = "valid-song-441707-t2"
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  project = "valid-song-441707-t2"
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "sqladmin" {
  project = "valid-song-441707-t2"
  service = "sqladmin.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
  project = "valid-song-441707-t2"
  service = "cloudbuild.googleapis.com"
}

# Instance SQL
resource "google_sql_database_instance" "main_instance" {
  name             = "main-instance"
  database_version = "MYSQL_8_0_31"
  region           = "us-central1"  # Région spécifiée ici
  tier             = "db-custom-2-8192"
  root_password    = "password123"
}

# Base de données MySQL
resource "google_sql_database" "wordpress" {
  name     = "wordpress"
  instance = google_sql_database_instance.main_instance.name
}

# Utilisateur MySQL
resource "google_sql_user" "wordpress" {
  name     = "wordpress"
  instance = google_sql_database_instance.main_instance.name
  password = "ilovedevops"
}
