terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("key.json")

  project = "igor-398900"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm" {
  name         = "vm"
  machine_type = "e2-micro"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = "echo oi > /teste.txt"
}

