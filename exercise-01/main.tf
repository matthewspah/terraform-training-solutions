provider "google" {
  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
}

resource "google_compute_instance" "vm_server" {
  name         = "dev-spah test VM"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params { 
      image = "debian-cloud/debian-9" 
    }
  } 

  metadata_startup_script = <<-EOF
              #!/bin/bash
              echo "${var.server_text}" > index.html
              nohup busybox httpd -f -p "${var.http_port}" &
              EOF  

  network_interface = { 
    network = "vpc-network-test" 
  }
}

resource "google_compute_network" "this_is_a_test" {
  name                    = "vpc-test-network"
  description             = "This is a test network"  
  auto_create_subnetworks = true
}

resource "google_compute_subnetwork" "testsubnet-devspah1" {}

resource "google_compute_subnetwork" "testsubnet-devspah2" {}




