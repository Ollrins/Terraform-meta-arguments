resource "yandex_compute_instance" "web" {
count = 2
name = "netology-develop-platform-web-${count.index + 1}"
platform_id = var.vm_res["web"].platform_id
zone        = var.vm_res["web"].zone
depends_on = [yandex_compute_instance.mr]

resources {
    cores         = var.vm_res["web"].cores
    memory        = var.vm_res["web"].memory
    core_fraction = var.vm_res["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_res["web"].disk_size
      type     = var.vm_res["web"].disk_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_res["web"].preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_res["web"].nat
    security_group_ids = ["enp581nv7hsvu30fgdbp"]
  }

  metadata = local.metadata 
}
