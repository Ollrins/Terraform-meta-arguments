resource "yandex_compute_disk" "disk" {
  count = 3
  name     = "disk-${count.index}"
  size = 1
}

resource "yandex_compute_instance" "storage" {
  name = "netology-develop-platform-storage"
  platform_id = var.vm_res["web"].platform_id
  zone        = var.vm_res["web"].zone
  dynamic "secondary_disk" {
        for_each = var.volumes
        content {
            disk_id = yandex_compute_disk.disk[secondary_disk.key].id
            auto_delete = var.server_volume_auto_delete
        }

}
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
    #security_group_ids = ["enp581nv7hsvu30fgdbp"]
  }

  metadata = local.metadata
}
