
###

module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}

###

  module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4421e3a5546a88dba619a88b46a6371ac7c90da4"
  env_name       = "production" 
  network_id     = module.vpc_prod.network_id
  subnet_zones   = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
  subnet_ids     = module.vpc_prod.subnet_ids
  instance_name  = "webs"
  instance_count = 3
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  platform       = "standard-v2"

  labels = { 
    owner= "i.ivanov",
    project = "accounting"
     }

    metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }
}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4421e3a5546a88dba619a88b46a6371ac7c90da4"
  env_name       = "develop"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_dev.subnet_ids[0]]  
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    public_ssh_key = file(var.vms_ssh_public_key_path)
  }
}

