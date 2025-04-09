variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
  sensitive   = true
}

variable "firewall_ip" {
  description = "Firewall IP in network account"
  type        = string
}