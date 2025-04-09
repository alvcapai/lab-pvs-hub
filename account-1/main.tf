provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

resource "ibm_is_vpc" "account1_vpc" {
  name = "account1-vpc"
}

resource "ibm_is_subnet" "account1_subnet" {
  name            = "account1-subnet"
  vpc             = ibm_is_vpc.account1_vpc.id
  zone            = "br-sao-1"
  ipv4_cidr_block = "172.16.0.0/24"
}

resource "ibm_is_vpc_routing_table" "account1_route_table" {
  vpc  = ibm_is_vpc.account1_vpc.id
  name = "account1-custom-route"
}

resource "ibm_is_vpc_routing_table_route" "to_account2_via_firewall" {
  routing_table = ibm_is_vpc_routing_table.account1_route_table.id
  destination   = "172.20.1.0/24"
  next_hop      = var.firewall_ip
}