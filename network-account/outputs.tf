output "hub_vpc_id" {
  value = ibm_is_vpc.network_hub_vpc.id
}

output "firewall_security_group_id" {
  value = ibm_is_security_group.firewall_sg.id
}