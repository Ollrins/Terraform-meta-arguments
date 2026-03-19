###cloud vars
variable "service_account_key_file" {
  type        = string
  description = "Path to service account key file"
}

variable "vms_ssh_public_key_path" {
  type        = string
  description = "Path to public SSH key file"
  default     = "/home/Ollrins/key.pub"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


###

variable "user" {
  type        = string
  default     = "ubuntu"
  description = "user for access"
}

variable "yandex_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"
}

variable "vn_web" {
  type        = string
  default     = "web"
  description = "web"
}


variable "vm_res" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
    disk_type     = string
    platform_id   = string
    zone          = string
    preemptible   = bool
    nat           = bool
  }))
  description = "vm resources"
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 50
      disk_size     = 10
      disk_type     = "network-hdd"
      platform_id   = "standard-v3"
      zone          = "ru-central1-a"
      preemptible   = true
      nat           = true
    }
  }
}

###

variable "each_vm" {
  type = map(object({ 
    vm_name     = string 
    cpu         = number 
    ram         = number 
    disk_volume = number 
  }))
  default = {
    main = {
      vm_name     = "main"
      cpu         = 4
      ram         = 4
      disk_volume = 10
    },
    replica = {
      vm_name     = "replica"
      cpu         = 2
      ram         = 4
      disk_volume = 8
    }
  }
}

variable "volumes" {
  description = "Volumes for secondary disks"
  type        = map(string)
  default = {
    "0" = "disk-0"
    "1" = "disk-1"
    "2" = "disk-2"
  }
}

variable "server_volume_auto_delete" {
  description = "Auto-delete volume with server"
  type        = bool
  default     = true
}
