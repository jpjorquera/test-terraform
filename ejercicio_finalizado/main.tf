terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.28.0"
    }
  }
}

provider "google" {
  # Configuration options
  region  = "us-central1"
  project = var.proyecto
}

resource "google_compute_instance" "ejemplo" {
  name         = "test"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  zone                    = data.google_compute_zones.available.names[0]
  metadata_startup_script = file("startup.sh")
}

variable "proyecto" {
  type        = string
  description = "Nombre del proyecto en que se despliega en GCP"
}

output "id" {
  value = google_compute_instance.ejemplo.id
}

data "google_compute_zones" "available" {
}

resource "google_compute_address" "static" {
  name = "nginx-address"
}

output "public_ip" {
  value = google_compute_address.static.address
}

resource "google_compute_firewall" "http" {
  name    = "http"
  network = "default"

  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  source_ranges = ["0.0.0.0/0"]
}