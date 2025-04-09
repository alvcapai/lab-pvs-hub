provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

resource "ibm_is_vpc" "network_hub_vpc" {
  name = "network-hub-vpc"
}

resource "ibm_is_subnet" "hub_subnet1" {
  name            = "hub-subnet-1"
  vpc             = ibm_is_vpc.network_hub_vpc.id
  zone            = "br-sao-1"
  ipv4_cidr_block = "172.24.0.0/24"
}

resource "ibm_is_subnet" "hub_subnet2" {
  name            = "hub-subnet-2"
  vpc             = ibm_is_vpc.network_hub_vpc.id
  zone            = "br-sao-2"
  ipv4_cidr_block = "172.25.0.0/24"
}

resource "ibm_is_security_group" "firewall_sg" {
  name = "firewall-sg"
  vpc  = ibm_is_vpc.network_hub_vpc.id
}

resource "ibm_is_security_group_rule" "allow_account1" {
  group     = ibm_is_security_group.firewall_sg.id
  direction = "inbound"
  remote    = "172.16.0.0/24"
  tcp {
    port_min = 1
    port_max = 65535
  }
}

resource "ibm_is_security_group_rule" "allow_account2" {
  group     = ibm_is_security_group.firewall_sg.id
  direction = "inbound"
  remote    = "172.20.1.0/24"
  tcp {
    port_min = 1
    port_max = 65535
  }
}