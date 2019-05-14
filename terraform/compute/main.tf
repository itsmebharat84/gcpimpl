// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("/Users/bharatbhushan/Workspace/gcp-keys/gcplearning-dbc4a6cc94e9.json")}"
 project     = "gcplearning-240600"
 region      = "asia-south1-c"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "gcpla-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "asia-south1-c"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
