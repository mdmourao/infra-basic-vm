resource "google_compute_network" "this" {
  name                    = var.project_name
  auto_create_subnetworks = false
}

output "network_name" {
  value = google_compute_network.this.name
}

resource "google_compute_subnetwork" "this" {
  name                     = "subnetwork"
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.this.id
  private_ip_google_access = true
}

output "subnetwork_name" {
  value = google_compute_subnetwork.this.name
}

resource "google_compute_firewall" "default-allow-https" {
  name      = "default-allow-https"
  network   = google_compute_network.this.name
  priority  = 1000
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

// Permits incoming connections instances from other instances within the same VPC network.
resource "google_compute_firewall" "default-allow-internal" {
  name      = "default-allow-internal"
  network   = google_compute_network.this.name
  priority  = 1000
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }
  source_ranges = [var.ip_cidr_range]
}

resource "google_compute_firewall" "custom-rule" {
  name      = "custom-rule"
  network   = google_compute_network.this.name
  priority  = 1000
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["50000", "50001"]
  }

  allow {
    protocol = "udp"
    ports    = ["50000", "50001"]
  }

  source_ranges = ["0.0.0.0/0"]
}

// 	Lets you connect to instances with tools such as ssh, scp, or sftp.
resource "google_compute_firewall" "default-allow-ssh" {
  name      = "default-allow-ssh"
  network   = google_compute_network.this.name
  priority  = 2000
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "deny-all" {
  name      = "deny-all"
  network   = google_compute_network.this.name
  priority  = 65534
  direction = "INGRESS"

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}
