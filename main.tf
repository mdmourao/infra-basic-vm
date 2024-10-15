module "network" {
  source        = "./modules/network"
  project_name  = var.project_name
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
}


module "compute_engine" {
  source       = "./modules/compute_engine"
  zone         = var.zone
  project_name = var.project_name

  machine_type = var.machine_type

  network_name    = module.network.network_name
  subnetwork_name = module.network.subnetwork_name
}
