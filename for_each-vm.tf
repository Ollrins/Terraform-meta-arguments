resource "yandex_compute_instance" "mr" {
for_each = var.each_vm
name = "netology-develop-platform-mr-${each.key}"
platform_id = var.vm_res["web"].platform_id
zone        = var.vm_res["web"].zone

resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.vm_res["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
      type    = var.vm_res["web"].disk_type
       
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_res["web"].nat
#    security_group_ids = ["enp581nv7hsvu30fgdbp"]
  }

  metadata = local.metadata
}


