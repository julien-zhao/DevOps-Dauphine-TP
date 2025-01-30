terraform {
  backend "gcs" {
    bucket = "valid-song-441707-t2-tfstate"  # Nom du bucket existant
    prefix = "terraform/state"               # Dossier pour le state
  }
}

