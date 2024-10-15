resource "google_compute_address" "ip-address" {
  name = "ipv4-address"
}

resource "google_compute_instance" "this" {
  name                      = "example-instance"
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = true

  boot_disk {
    auto_delete = false
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    access_config {
      nat_ip = google_compute_address.ip-address.address
    }
  }
}
