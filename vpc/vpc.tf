terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.193.0"
    }
  }
}

variable "env_name" {
  type        = string
  description = "Env name (production, develop)"
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "subnets with zones and CIDR blocks"
}

resource "yandex_vpc_network" "main" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "main" {
  count = length(var.subnets)

  name           = "${var.env_name}-${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
}

output "network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.main.id
}

output "subnet_ids" {
  description = "IDs of all created subnets"
  value       = yandex_vpc_subnet.main[*].id
}

output "subnet_info" {
  description = "Complete subnet objects with all attributes"
  value       = yandex_vpc_subnet.main
}
