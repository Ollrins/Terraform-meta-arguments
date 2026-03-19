output "vm_details" {
  description = "VM details in compact format"
   value = concat(
    [for vm in yandex_compute_instance.web : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }],
    [for vm in values(yandex_compute_instance.mr) : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }],
    [{
      name = yandex_compute_instance.storage.name
      id   = yandex_compute_instance.storage.id
      fqdn = yandex_compute_instance.storage.fqdn
    }]
  )
}
