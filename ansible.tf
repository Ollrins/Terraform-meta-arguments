resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl",
    {
      web_hosts = yandex_compute_instance.web[*]
      db_hosts  = values(yandex_compute_instance.mr)[*]
      storage_hosts = [yandex_compute_instance.storage]
    }
  )
  filename = "${path.module}/inventory.ini"
}
