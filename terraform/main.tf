# Set the variable value in *.tfvars file for local run
variable "do_token" {}

# Set up the variable value in *.tfvars file for local run
variable "public_key" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# SSH Key - Created in GHA Workflow
resource "digitalocean_ssh_key" "dynamic_key" {
  name       = "github-actions-key"
  public_key = var.public_key
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  image   = "ubuntu-22-04-x64"
  name    = "web-vpnSS"
  region  = "nyc2"
  size    = "s-1vcpu-1gb"
  backups = true

  ssh_keys = [digitalocean_ssh_key.dynamic_key.id]
}

# Capture outputs of droplet
output "droplet_info" {
  value = {
    id   = digitalocean_droplet.web.id
    name = digitalocean_droplet.web.name
    ipv4 = digitalocean_droplet.web.ipv4_address
  }
}