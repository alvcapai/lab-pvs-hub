provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

resource "ibm_is_vpc" "account2_vpc" {
  name = "account2-vpc"
}

resource "ibm_is_subnet" "account2_subnet" {
  name            = "account2-subnet"
  vpc             = ibm_is_vpc.account2_vpc.id
  zone            = "br-sao-1"
  ipv4_cidr_block = "172.20.1.0/24"
}

resource "ibm_is_vpc_routing_table" "account2_route_table" {
  vpc  = ibm_is_vpc.account2_vpc.id
  name = "account2-custom-route"
}

resource "ibm_is_vpc_routing_table_route" "to_account1_via_firewall" {
  routing_table = ibm_is_vpc_routing_table.account2_route_table.id
  destination   = "172.16.0.0/24"
  next_hop      = var.firewall_ip
}